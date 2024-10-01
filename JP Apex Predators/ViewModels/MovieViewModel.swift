//
//  MovieViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation
import SwiftUI
import SystemConfiguration

@Observable
class MovieViewModel {
    
    var parts = [Part]()
    
    var animate = false
    let firstColor = Color("FirstButtonColor")
    let secondColor = Color("SecondButtonColor")
    
    func fetcData() {
        MovieAPIManager().getData() { new in
            DispatchQueue.main.async {
                withAnimation {
                    self.parts = new
                }
            }
        }
    }
    
    func isInternetAvailable() -> Bool
        {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)

            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }

            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            return (isReachable && !needsConnection)
        }
}
