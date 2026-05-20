#import "SASGMANativeAdapter.h"
#import "SASMediatedNativeAd.h"
#import "SASGMAUtils.h"
#import "SASGMAAdNetworkExtras.h"

@interface SASGMANativeAdapter ()

@property (nonatomic, strong) SASNativeAdView *nativeAdView;
@property (nonatomic, strong, nullable) SASNativeAdAssets *nativeAdAssets;
@property (nonatomic, copy, nullable) GADMediationNativeLoadCompletionHandler loadCompletionHandler;
@property (nonatomic, weak, nullable) id<GADMediationNativeAdEventDelegate> delegate;
@property (nonatomic, strong, nullable) SASMediatedNativeAd *mediatedNativeAd;
@property (nonatomic, strong) UIView *nativeAdViewBaseLayout;
@property (nonatomic, strong) UIView *nativeAdViewCustomerFeedbackButtonContainer;

@end

@implementation SASGMANativeAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        _nativeAdView = [[SASNativeAdView alloc] initWithFrame:CGRectZero];
        _nativeAdViewBaseLayout = [[UIView alloc] initWithFrame:CGRectZero];
        _nativeAdViewCustomerFeedbackButtonContainer = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

+ (GADVersionNumber)adapterVersion {
    return [SASGMAUtils adapterVersion];
}

+ (GADVersionNumber)adSDKVersion {
    return [SASGMAUtils adSDKVersion];
}

+ (nullable Class<GADAdNetworkExtras>)networkExtrasClass {
    return [SASGMAAdNetworkExtras class];
}

- (void)loadNativeAdForAdConfiguration:(GADMediationNativeAdConfiguration *)adConfiguration
                     completionHandler:(GADMediationNativeLoadCompletionHandler)completionHandler {
    SASAdPlacement *placement = [SASGMAUtils placementWithAdConfiguration:adConfiguration];
    
    if (!placement) {
        // Placement is invalid, sending an error
        NSError *error = [NSError errorWithDomain:SASGMAUtils.kSASGMAErrorDomain
                                             code:SASGMAUtils.kSASGMAErrorCodeInvalidServerParameters
                                         userInfo:nil];
        completionHandler(nil, error);
        return;
    }
    
    self.loadCompletionHandler = completionHandler;
    
    self.nativeAdView.modalParentViewController = adConfiguration.topViewController;
    self.nativeAdView.delegate = self;
    
    // Load the native ad
    [self.nativeAdView loadAdWithAdPlacement:placement];
}

- (BOOL)handlesUserClicks {
    return YES;
}

- (BOOL)handlesUserImpressions {
    return YES;
}

#pragma mark - SASNativeAdViewDelegate

- (void)nativeAdView:(nonnull SASNativeAdView *)nativeAdView
     didLoadWithInfo:(nonnull SASAdInfo *)adInfo
      nativeAdAssets:(nonnull SASNativeAdAssets *)nativeAdAssets {
    self.nativeAdAssets = nativeAdAssets;
    
    self.mediatedNativeAd = [[SASMediatedNativeAd alloc]
                             initWithNativeAdView:nativeAdView
                             nativeAdAssets:nativeAdAssets
                             customerFeedbackButtonContainer:self.nativeAdViewCustomerFeedbackButtonContainer];
    
    __weak typeof(self) weakSelf = self;
    [self.mediatedNativeAd fetchAssetsIfNeededWithCompletionHandler:^(NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        if (error) {
            if (strongSelf.loadCompletionHandler) {
                strongSelf.loadCompletionHandler(nil, error);
                strongSelf.loadCompletionHandler = nil;
            }
        } else {
            if (strongSelf.loadCompletionHandler) {
                strongSelf.delegate = strongSelf.loadCompletionHandler(strongSelf.mediatedNativeAd, nil);
                strongSelf.mediatedNativeAd.gadDelegate = strongSelf.delegate;
                strongSelf.loadCompletionHandler = nil;
            }
        }
    }];
}

- (void)nativeAdView:(nonnull SASNativeAdView *)nativeAdView didFailToLoadWithError:(nonnull NSError *)error {
    if (self.loadCompletionHandler) {
        self.loadCompletionHandler(nil, error);
        self.loadCompletionHandler = nil;
    }
}

- (void)nativeAdViewClicked:(nonnull SASNativeAdView *)nativeAdView {
    [self.delegate reportClick];
}

@end
