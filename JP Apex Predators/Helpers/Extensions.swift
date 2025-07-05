//
//  Extensions.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 26.09.2024.
//

import StoreKit
import RevenueCat

extension SKProductSubscriptionPeriod {
    var durationTitle: String {
        switch self.unit {
        case .day: return "day"
        case .week: return "week"
        case .month: return "month"
        case .year: return "year"
        @unknown default: return "Unknown"
        }
    }

    var periodTitle: String {
        "\(self.numberOfUnits) \(self.durationTitle)\(self.numberOfUnits > 1 ? "s" : "")"
    }
}

extension Package {
    var terms: String {
        guard let intro = storeProduct.introductoryDiscount,
              let sk1 = intro.sk1Discount else {
            return "Unlocks Premium"
        }
        let period = sk1.subscriptionPeriod
        if intro.price == 0 {
            return "\(period.periodTitle) free trial"
        } else {
            return "\(localizedIntroductoryPriceString!) for \(period.periodTitle)"
        }
    }
}
