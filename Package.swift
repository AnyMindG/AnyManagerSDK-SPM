// swift-tools-version:5.6
// Copyright 2024 AnyMind Group
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
    // GMA Core — has version tags, use range
    .package(
      url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
      "11.0.0"..<"15.0.0"
    ),
    // Adapters — no name: parameter in 5.6+
    .package(
      url: "https://github.com/googleads/googleads-mobile-ios-mediation-applovin.git",
      branch: "main"
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
      branch: "main"
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
      url: "https://github.com/Ogury/ogury-google-adapter-spm",
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
        // In 5.6+, package: uses the last path component of the URL automatically
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
        .product(name: "OguryMediationGoogleMobileAds",
                 package: "ogury-google-adapter-spm"),
        .product(name: "SmartDisplaySDK",
                 package: "swift-package-manager-display-sdk"),
      ],
      path: "AnyManagerSDKTarget"
    ),
  ]
)
