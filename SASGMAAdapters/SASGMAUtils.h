//
//  SASGMAUtils.h
//  AnyManagerSDKDemoApp
//
//  Created by Narender on 28/05/25.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SASGMAAdNetworkExtras;

@interface SASGMAUtils : NSObject

// Constants
@property (class, nonatomic, readonly) NSString *SASImplementationInfo_PrimarySDKName;
@property (class, nonatomic, readonly) NSInteger SASImplementationInfo_MediationAdapterVersion_Major;
@property (class, nonatomic, readonly) NSInteger SASImplementationInfo_MediationAdapterVersion_Minor;
@property (class, nonatomic, readonly) NSInteger SASImplementationInfo_MediationAdapterVersion_Patch;
@property (class, nonatomic, readonly) NSString *adaptersVersionString;

@property (class, nonatomic, readonly) NSString *kSASGMAErrorDomain;
@property (class, nonatomic, readonly) NSInteger kSASGMAErrorCodeInvalidServerParameters;
@property (class, nonatomic, readonly) NSInteger kSASGMAErrorCodeCannotFetchNativeAdAssets;
@property (class, nonatomic, readonly) NSInteger kSASGMAErrorCodeFailToLoadNativeAd;

// Methods
+ (GADVersionNumber)adapterVersion;
+ (GADVersionNumber)adSDKVersion;
+ (nullable SASAdPlacement *)placementWithAdConfiguration:(GADMediationAdConfiguration *)adConfiguration;

// Deprecated method
+ (nullable SASAdPlacement *)placementWithServerParameter:(nullable NSString *)serverParameter
                                                  request:(nullable GADCustomEventRequest *)request
                                                   extras:(nullable SASGMAAdNetworkExtras *)extras
    DEPRECATED_MSG_ATTRIBUTE("use placementWithAdConfiguration: instead");

@end

NS_ASSUME_NONNULL_END
