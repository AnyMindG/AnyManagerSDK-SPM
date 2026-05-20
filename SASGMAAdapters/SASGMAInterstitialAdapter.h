#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SASGMAInterstitialAdapter : NSObject <GADMediationAdapter, GADMediationInterstitialAd, SASInterstitialManagerDelegate>

@end

NS_ASSUME_NONNULL_END
