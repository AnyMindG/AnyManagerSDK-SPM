#import "SASGMABannerAdapter.h"
#import "SASGMAUtils.h"
#import "SASGMAAdNetworkExtras.h"

@interface SASGMABannerAdapter ()

@property (nonatomic, strong, readwrite) UIView *view;
@property (nonatomic, copy, nullable) GADMediationBannerLoadCompletionHandler loadCompletionHandler;
@property (nonatomic, weak, nullable) id<GADMediationBannerAdEventDelegate> delegate;

@end

@implementation SASGMABannerAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        _view = [[SASBannerView alloc] initWithFrame:CGRectZero];
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

- (void)loadBannerForAdConfiguration:(GADMediationBannerAdConfiguration *)adConfiguration
                   completionHandler:(GADMediationBannerLoadCompletionHandler)completionHandler {
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
    
    if ([self.view isKindOfClass:[SASBannerView class]]) {
        SASBannerView *bannerView = (SASBannerView *)self.view;
        bannerView.frame = CGRectMake(0, 0, adConfiguration.adSize.size.width, adConfiguration.adSize.size.height);
        bannerView.modalParentViewController = adConfiguration.topViewController;
        bannerView.delegate = self;
        
        // Load the banner ad
        [bannerView loadAdWithAdPlacement:placement];
    }
}

#pragma mark - SASBannerViewDelegate

- (void)bannerView:(nonnull SASBannerView *)bannerView didLoadWithInfo:(nonnull SASAdInfo *)adInfo {
    if (self.loadCompletionHandler) {
        self.delegate = self.loadCompletionHandler(self, nil);
        self.loadCompletionHandler = nil;
    }
    [self.delegate reportImpression];
}

- (void)bannerView:(nonnull SASBannerView *)bannerView didFailToLoadWithError:(nonnull NSError *)error {
    if (self.loadCompletionHandler) {
        self.loadCompletionHandler(nil, error);
        self.loadCompletionHandler = nil;
    }
}

- (void)bannerViewClicked:(nonnull SASBannerView *)bannerView {
    [self.delegate reportClick];
}

- (void)bannerViewDidExpand:(nonnull SASBannerView *)bannerView {
    [self.delegate willPresentFullScreenView];
}

- (void)bannerViewDidCollapse:(nonnull SASBannerView *)bannerView {
    [self.delegate willDismissFullScreenView];
}

- (void)bannerViewDidRequestClose:(nonnull SASBannerView *)bannerView {
    // Nothing to do
}

@end
