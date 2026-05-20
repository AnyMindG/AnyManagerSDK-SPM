//
//  SASMediatedNativeAd.h
//  AnyManagerSDKDemoApp
//
//  Created by Narender on 28/05/25.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SASMediatedNativeAd : NSObject <GADMediationNativeAd>

@property (nonatomic, weak, nullable) id<GADMediationNativeAdEventDelegate> gadDelegate;

- (instancetype)initWithNativeAdView:(SASNativeAdView *)nativeAdView
                     nativeAdAssets:(SASNativeAdAssets *)nativeAdAssets
   customerFeedbackButtonContainer:(nullable UIView *)customerFeedbackButtonContainer;

- (void)fetchAssetsIfNeededWithCompletionHandler:(void (^)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
