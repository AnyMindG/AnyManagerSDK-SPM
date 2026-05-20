//
//  SASGMAUtils.m
//  AnyManagerSDKDemoApp
//
//  Created by Narender on 28/05/25.
//

#import "SASGMAUtils.h"
#import "SASGMAAdNetworkExtras.h"

static NSString *const kCustomEventServerSeparatorString = @"/";

@implementation SASGMAUtils

#pragma mark - Class Properties

+ (NSString *)SASImplementationInfo_PrimarySDKName {
    return @"GoogleMobileAds";
}

+ (NSInteger)SASImplementationInfo_MediationAdapterVersion_Major {
    return 2;
}

+ (NSInteger)SASImplementationInfo_MediationAdapterVersion_Minor {
    return 0;
}

+ (NSInteger)SASImplementationInfo_MediationAdapterVersion_Patch {
    return 0;
}

+ (NSString *)adaptersVersionString {
    return [NSString stringWithFormat:@"%ld.%ld.%ld",
            (long)[self SASImplementationInfo_MediationAdapterVersion_Major],
            (long)[self SASImplementationInfo_MediationAdapterVersion_Minor],
            (long)[self SASImplementationInfo_MediationAdapterVersion_Patch]];
}

+ (NSString *)kSASGMAErrorDomain {
    return @"kSASGMAErrorDomain";
}

+ (NSInteger)kSASGMAErrorCodeInvalidServerParameters {
    return 100;
}

+ (NSInteger)kSASGMAErrorCodeCannotFetchNativeAdAssets {
    return 101;
}

+ (NSInteger)kSASGMAErrorCodeFailToLoadNativeAd {
    return 102;
}

#pragma mark - Public Methods

+ (GADVersionNumber)adapterVersion {
    GADVersionNumber version;
    version.majorVersion = [self SASImplementationInfo_MediationAdapterVersion_Major];
    version.minorVersion = [self SASImplementationInfo_MediationAdapterVersion_Minor];
    version.patchVersion = [self SASImplementationInfo_MediationAdapterVersion_Patch];
    return version;
}

+ (GADVersionNumber)adSDKVersion {
    NSString *versionString = [SASFrameworkInfo sharedInstance].frameworkVersionString;
    NSArray<NSString *> *versions = [versionString componentsSeparatedByString:@"."];
    
    NSInteger majorVersion = versions.count > 0 ? [versions[0] integerValue] : 0;
    NSInteger minorVersion = versions.count > 1 ? [versions[1] integerValue] : 0;
    NSInteger patchVersion = versions.count > 2 ? [versions[2] integerValue] : 0;
    
    GADVersionNumber version;
    version.majorVersion = majorVersion;
    version.minorVersion = minorVersion;
    version.patchVersion = patchVersion;
    return version;
}

+ (nullable SASAdPlacement *)placementWithAdConfiguration:(GADMediationAdConfiguration *)adConfiguration {
    NSString *parameter = adConfiguration.credentials.settings[@"parameter"];
    
    if (!parameter) {
        return nil;
    }
    
    NSInteger siteId = 0;
    NSInteger pageId = 0;
    NSInteger formatId = 0;
    
    // Processing the server parameter string
    NSArray<NSString *> *stringComponents = [parameter componentsSeparatedByString:kCustomEventServerSeparatorString];
    
    for (NSUInteger i = 0; i < stringComponents.count; i++) {
        NSString *component = stringComponents[i];
        switch (i) {
            case 0:
                siteId = [component integerValue];
                break;
            case 1:
                pageId = [component integerValue];
                break;
            case 2:
                formatId = [component integerValue];
                break;
            default:
                break;
        }
    }
    
    // Rejecting invalid parameters
    if (siteId == 0 || pageId == 0 || formatId == 0) {
        return nil;
    }
    
    NSString *targetingString = nil;
    
    if ([adConfiguration.extras isKindOfClass:[SASGMAAdNetworkExtras class]]) {
        SASGMAAdNetworkExtras *extras = (SASGMAAdNetworkExtras *)adConfiguration.extras;
        // Processing keywords targeting string
        targetingString = [extras.keywords componentsJoinedByString:@";"];
    }
    
    // Configure the Equativ Display SDK
    [[SASConfiguration sharedInstance] configure];
    
    NSString *versionString = GADGetStringFromVersionNumber([GADMobileAds sharedInstance].versionNumber);
    SASSecondaryImplementationInfo *secondaryInfo = [[SASSecondaryImplementationInfo alloc]
                                                     initWithPrimarySDKName:[self SASImplementationInfo_PrimarySDKName]
                                                     primarySDKVersion:versionString
                                                     mediationAdapterVersion:[self adaptersVersionString]];
    [SASConfiguration sharedInstance].secondaryImplementationInfo = secondaryInfo;
    
    // Ad placement instantiation
    return [[SASAdPlacement alloc] initWithSiteId:siteId
                                           pageId:pageId
                                         formatId:formatId
                                 keywordTargeting:targetingString];
}

+ (nullable SASAdPlacement *)placementWithServerParameter:(nullable NSString *)serverParameter
                                                  request:(nullable GADCustomEventRequest *)request
                                                   extras:(nullable SASGMAAdNetworkExtras *)extras {
    if (!serverParameter) {
        return nil;
    }
    
    NSInteger siteId = 0;
    NSInteger pageId = 0;
    NSInteger formatId = 0;
    
    // Processing the server parameter string
    NSArray<NSString *> *stringComponents = [serverParameter componentsSeparatedByString:kCustomEventServerSeparatorString];
    
    for (NSUInteger i = 0; i < stringComponents.count; i++) {
        NSString *component = stringComponents[i];
        switch (i) {
            case 0:
                siteId = [component integerValue];
                break;
            case 1:
                pageId = [component integerValue];
                break;
            case 2:
                formatId = [component integerValue];
                break;
            default:
                break;
        }
    }
    
    // Rejecting invalid parameters
    if (siteId == 0 || pageId == 0 || formatId == 0) {
        return nil;
    }
    
    NSString *targetingString = nil;
    
    if (request) {
        if ([request.userKeywords isKindOfClass:[NSArray class]]) {
            NSArray<NSString *> *keywords = (NSArray<NSString *> *)request.userKeywords;
            targetingString = [keywords componentsJoinedByString:@";"];
        }
    }
    
    if (extras) {
        // Processing keywords targeting string
        targetingString = [extras.keywords componentsJoinedByString:@";"];
    }
    
    // Configure the Equativ Display SDK
    [[SASConfiguration sharedInstance] configure];
    
    NSString *versionString = GADGetStringFromVersionNumber([GADMobileAds sharedInstance].versionNumber);
    SASSecondaryImplementationInfo *secondaryInfo = [[SASSecondaryImplementationInfo alloc]
                                                     initWithPrimarySDKName:[self SASImplementationInfo_PrimarySDKName]
                                                     primarySDKVersion:versionString
                                                     mediationAdapterVersion:[self adaptersVersionString]];
    [SASConfiguration sharedInstance].secondaryImplementationInfo = secondaryInfo;
    
    // Ad placement instantiation
    return [[SASAdPlacement alloc] initWithSiteId:siteId
                                           pageId:pageId
                                         formatId:formatId
                                 keywordTargeting:targetingString];
}

@end
