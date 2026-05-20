// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "AnyManagerSDK",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "AnyManagerSDK",
      targets: ["AnyManagerSDKTarget"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
      "13.0.0"..<"15.0.0"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-applovin.git",
      exact: "13.6.200"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-chartboost.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-dtexchange.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-inmobi.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-ironsource.git",
      exact: "9.4.100"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-liftoffmonetize.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-line.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-meta.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-mintegral.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-moloco.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-pangle.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-unity.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/smartadserver/swift-package-manager-display-sdk.git",
      branch: "main"
    ),
  ],
  targets: [
    .target(
      name: "AnyManagerSDKTarget",
      dependencies: [
        .product(name: "GoogleMobileAds",
                 package: "swift-package-manager-google-mobile-ads"),
        .product(name: "AppLovinAdapterTarget",
                 package: "googleads-mobile-ios-mediation-applovin"),
        .product(name: "ChartboostAdapterTarget",
                 package: "googleads-mobile-ios-mediation-chartboost"),
        .product(name: "DTExchangeAdapterTarget",
                 package: "googleads-mobile-ios-mediation-dtexchange"),
        .product(name: "InMobiAdapterTarget",
                 package: "googleads-mobile-ios-mediation-inmobi"),
        .product(name: "IronSourceAdapterTarget",
                 package: "googleads-mobile-ios-mediation-ironsource"),
        .product(name: "LiftoffMonetizeAdapterTarget",
                 package: "googleads-mobile-ios-mediation-liftoffmonetize"),
        .product(name: "LineAdapterTarget",
                 package: "googleads-mobile-ios-mediation-line"),
        .product(name: "MetaAdapterTarget",
                 package: "googleads-mobile-ios-mediation-meta"),
        .product(name: "MintegralAdapterTarget",
                 package: "googleads-mobile-ios-mediation-mintegral"),
        .product(name: "MolocoAdapterTarget",
                 package: "googleads-mobile-ios-mediation-moloco"),
        .product(name: "PangleAdapterTarget",
                 package: "googleads-mobile-ios-mediation-pangle"),
        .product(name: "UnityAdapterTarget",
                 package: "googleads-mobile-ios-mediation-unity"),
        .product(name: "SASDisplayKit",
                 package: "swift-package-manager-display-sdk"),
      ],
      path: "AnyManagerSDKTarget"
    ),
  ]
)
