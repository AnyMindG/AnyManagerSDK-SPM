//
//  SASGMANativeAdapter.h
//  AnyManagerSDKDemoApp
//
//  Created by Narender on 28/05/25.
//

// SASGMANativeAdapter.h
#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SASGMANativeAdapter : NSObject <GADMediationAdapter, SASNativeAdViewDelegate>

@end

NS_ASSUME_NONNULL_END
