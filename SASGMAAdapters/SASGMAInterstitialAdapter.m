#import "SASGMAInterstitialAdapter.h"
#import "SASGMAUtils.h"
#import "SASGMAAdNetworkExtras.h"

@interface SASGMAInterstitialAdapter ()

@property (nonatomic, strong, nullable) SASInterstitialManager *interstitialManager;
@property (nonatomic, copy, nullable) GADMediationInterstitialLoadCompletionHandler loadCompletionHandler;
@property (nonatomic, weak, nullable) id<GADMediationInterstitialAdEventDelegate> delegate;

@end

@implementation SASGMAInterstitialAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialization if needed
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

#pragma mark - Adapter lifecycle

- (void)loadInterstitialForAdConfiguration:(GADMediationInterstitialAdConfiguration *)adConfiguration
                         completionHandler:(GADMediationInterstitialLoadCompletionHandler)completionHandler {
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
    
    // Instantiating the interstitial manager
    self.interstitialManager = [[SASInterstitialManager alloc] initWithAdPlacement:placement];
    self.interstitialManager.delegate = self;
    
    // Load the interstitial ad
    [self.interstitialManager loadAd];
}

- (void)presentFromViewController:(UIViewController *)viewController {
    if (self.interstitialManager.adStatus == SASAdStatusReady) {
        // Show interstitial only if ready
        [self.interstitialManager showFromViewController:viewController];
    }
}

#pragma mark - SASInterstitialManagerDelegate

- (void)interstitialManager:(nonnull SASInterstitialManager *)interstitialManager didLoadWithInfo:(nonnull SASAdInfo *)adInfo {
    if (self.loadCompletionHandler) {
        self.delegate = self.loadCompletionHandler(self, nil);
        self.loadCompletionHandler = nil;
    }
}

- (void)interstitialManager:(nonnull SASInterstitialManager *)interstitialManager didFailToLoadWithError:(nonnull NSError *)error {
    if (self.loadCompletionHandler) {
        self.loadCompletionHandler(nil, error);
        self.loadCompletionHandler = nil;
    }
}

- (void)interstitialManagerDidShow:(nonnull SASInterstitialManager *)interstitialManager {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
}

- (void)interstitialManagerDidClose:(nonnull SASInterstitialManager *)interstitialManager {
    [self.delegate willDismissFullScreenView];
}

- (void)interstitialManagerClicked:(nonnull SASInterstitialManager *)interstitialManager {
    [self.delegate reportClick];
}

@end
