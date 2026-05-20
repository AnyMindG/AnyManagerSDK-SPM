#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SASGMABannerAdapter : NSObject <GADMediationAdapter, GADMediationBannerAd, SASBannerViewDelegate>

@property (nonatomic, strong, readonly) UIView *view;

@end

NS_ASSUME_NONNULL_END


