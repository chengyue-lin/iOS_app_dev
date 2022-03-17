//
//  AppStoreReviewManager.swift
//  finalProject
//
//  Created by 周越 on 3/17/22.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    static let minimumReviewWorthyActionCount = 3

    static func requestReviewIfAppropriate() {
        let defaults = UserDefaults.standard
//        let bundle = Bundle.main

        // 2.
        var actionCount = defaults.integer(forKey:"reviewWorthyActionCount")

        // 3.
        actionCount += 1

        // 4.
        defaults.set(actionCount, forKey: "reviewWorthyActionCount")

        // 5.
        guard actionCount >= minimumReviewWorthyActionCount else {
            return
        }
//        let bundleVersionKey = kCFBundleVersionKey as String
//        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
//        let lastVersion = defaults.string(forKey: .lastReviewRequestAppVersion)

        // 7.
//        guard lastVersion == nil || lastVersion != currentVersion else {
//            return
//        }
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
          SKStoreReviewController.requestReview(in: scene)
        }
        defaults.set(0, forKey: "reviewWorthyActionCount")
//        defaults.set(currentVersion, forKey: .lastReviewRequestAppVersion)
    }
}
