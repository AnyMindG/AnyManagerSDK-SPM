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
    // ⚠️ Pinned to last working tag — 13.6.2.1 zip is 404 on HEAD
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-applovin.git",
      .revision("e88a51fc21147d924c3e754d9c5c398283b1810b")  // tag 13.6.200
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
    // ⚠️ IronSource — paste revision hash after running ls-remote
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-ironsource.git",
      .revision("PASTE_IRONSOURCE_WORKING_COMMIT_HASH")
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
        .product(name: "AppLovinAdapter",
                 package: "googleads-mobile-ios-mediation-applovin"),
        .product(name: "ChartboostAdapter",
                 package: "googleads-mobile-ios-mediation-chartboost"),
        .product(name: "DTExchangeAdapter",
                 package: "googleads-mobile-ios-mediation-dtexchange"),
        .product(name: "InMobiAdapter",
                 package: "googleads-mobile-ios-mediation-inmobi"),
        .product(name: "IronSourceAdapter",
                 package: "googleads-mobile-ios-mediation-ironsource"),
        .product(name: "LiftoffMonetizeAdapter",
                 package: "googleads-mobile-ios-mediation-liftoffmonetize"),
        .product(name: "LineAdapter",
                 package: "googleads-mobile-ios-mediation-line"),
        .product(name: "MetaAdapter",
                 package: "googleads-mobile-ios-mediation-meta"),
        .product(name: "MintegralAdapter",
                 package: "googleads-mobile-ios-mediation-mintegral"),
        .product(name: "MolocoAdapter",
                 package: "googleads-mobile-ios-mediation-moloco"),
        .product(name: "PangleAdapter",
                 package: "googleads-mobile-ios-mediation-pangle"),
        .product(name: "UnityAdsAdapter",
                 package: "googleads-mobile-ios-mediation-unity"),
        .product(name: "SmartDisplaySDK",
                 package: "swift-package-manager-display-sdk"),
      ],
      path: "AnyManagerSDKTarget"
    ),
  ]
)
