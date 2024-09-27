//
//  PaywallViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 26.09.2024.
//

import Foundation
import SwiftUI
import RevenueCat

@Observable
class PaywallViewModel {
    
    var isPaywallPresented = false
    var isSubsriptionActive = false
    
    init() {
        
        Purchases.configure(withAPIKey: "appl_COoVDmAQazLwdADseTbEwSXPzkr")
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            
            self.isSubsriptionActive = customerInfo?.entitlements.all["Pro"]?.isActive == true
            }
        }
    }
