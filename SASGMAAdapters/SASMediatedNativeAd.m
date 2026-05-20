//
//  SASMediatedNativeAd.m
//  AnyManagerSDKDemoApp
//
//  Created by Narender on 28/05/25.
//

// SASMediatedNativeAd.m
#import "SASMediatedNativeAd.h"
#import "SASGMAUtils.h"

@interface SASMediatedNativeAd ()

@property (nonatomic, strong) SASNativeAdView *sasNativeAdView;
@property (nonatomic, strong) SASNativeAdAssets *sasNativeAdAssets;
@property (nonatomic, strong, nullable) NSArray<GADNativeAdImage *> *mappedImages;
@property (nonatomic, strong, nullable) GADNativeAdImage *icon;  // Add this property

@end

@implementation SASMediatedNativeAd

- (instancetype)initWithNativeAdView:(SASNativeAdView *)nativeAdView
                      nativeAdAssets:(SASNativeAdAssets *)nativeAdAssets
    customerFeedbackButtonContainer:(nullable UIView *)customerFeedbackButtonContainer {
    self = [super init];
    if (self) {
        _sasNativeAdView = nativeAdView;
        _sasNativeAdAssets = nativeAdAssets;
    }
    return self;
}

#pragma mark - GADMediationNativeAd Protocol

- (nullable UIView *)adChoicesView {
    return nil;
}

- (nullable NSString *)advertiser {
    return nil;
}

- (nullable NSString *)body {
    return self.sasNativeAdAssets.body;
}

- (nullable NSString *)callToAction {
    return self.sasNativeAdAssets.callToAction;
}

- (nullable NSDictionary<NSString *, id> *)extraAssets {
    return nil;
}

- (BOOL)hasVideoContent {
    return NO;
}

- (nullable NSString *)headline {
    return self.sasNativeAdAssets.title;
}

- (nullable GADNativeAdImage *)icon {
    return _icon;
}

- (nullable NSArray<GADNativeAdImage *> *)images {
    return self.mappedImages;
}

- (nullable UIView *)mediaView {
    return nil;
}

- (nullable NSString *)price {
    return nil;
}

- (nullable NSDecimalNumber *)starRating {
    if (self.sasNativeAdAssets.rating) {
        return [NSDecimalNumber decimalNumberWithDecimal:[self.sasNativeAdAssets.rating decimalValue]];
    }
    return nil;
}

- (nullable NSString *)store {
    return nil;
}

- (void)didRenderInView:(UIView *)view
       clickableAssetViews:(NSDictionary<GADNativeAssetIdentifier, UIView *> *)clickableAssetViews
    nonclickableAssetViews:(NSDictionary<GADNativeAssetIdentifier, UIView *> *)nonclickableAssetViews
            viewController:(UIViewController *)viewController {
    // Tracking the mediation view using the Equativ SDK in order to fire
    // the impression & tracking pixels and in order to handle the click properly
    [self.sasNativeAdView trackMediationView:view];
    
    // Logging impression to GMA
    [self.gadDelegate reportImpression];
}

#pragma mark - Asset Fetching

- (void)fetchAssetsIfNeededWithCompletionHandler:(void (^)(NSError * _Nullable))completionHandler {
    __block BOOL errorOccurred = NO;
    dispatch_group_t downloadAssetsGroup = dispatch_group_create();
    
    if (self.sasNativeAdAssets.iconImage.url) {
        NSURL *iconUrl = self.sasNativeAdAssets.iconImage.url;
        
        dispatch_group_enter(downloadAssetsGroup);
        
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:iconUrl
                                                                     completionHandler:^(NSData * _Nullable data,
                                                                                       NSURLResponse * _Nullable response,
                                                                                       NSError * _Nullable error) {
            if (data) {
                UIImage *iconImage = [UIImage imageWithData:data];
                if (iconImage) {
                    self.icon = [[GADNativeAdImage alloc] initWithImage:iconImage];
                } else {
                    errorOccurred = YES;
                }
            } else {
                errorOccurred = YES;
            }
            
            dispatch_group_leave(downloadAssetsGroup);
        }];
        
        [dataTask resume];
    }
    
    if (self.sasNativeAdAssets.mainView.url) {
        NSURL *mainViewUrl = self.sasNativeAdAssets.mainView.url;
        
        dispatch_group_enter(downloadAssetsGroup);
        
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:mainViewUrl
                                                                     completionHandler:^(NSData * _Nullable data,
                                                                                       NSURLResponse * _Nullable response,
                                                                                       NSError * _Nullable error) {
            if (data) {
                UIImage *mainViewImage = [UIImage imageWithData:data];
                if (mainViewImage) {
                    GADNativeAdImage *nativeAdImage = [[GADNativeAdImage alloc] initWithImage:mainViewImage];
                    self.mappedImages = @[nativeAdImage];
                } else {
                    errorOccurred = YES;
                }
            } else {
                errorOccurred = YES;
            }
            
            dispatch_group_leave(downloadAssetsGroup);
        }];
        
        [dataTask resume];
    }
    
    dispatch_group_notify(downloadAssetsGroup, dispatch_get_main_queue(), ^{
        if (errorOccurred) {
            NSError *error = [NSError errorWithDomain:SASGMAUtils.kSASGMAErrorDomain
                                                 code:SASGMAUtils.kSASGMAErrorCodeCannotFetchNativeAdAssets
                                             userInfo:nil];
            completionHandler(error);
        } else {
            completionHandler(nil);
        }
    });
}

@end
