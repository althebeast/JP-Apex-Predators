//
//  Paywall.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 25.09.2024.
//

import SwiftUI
import RevenueCat

struct Paywall: View {
    
    @State var currentOffering: Offering?
    
    @Environment(PaywallViewModel.self) var paywallViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                LinearGradient(colors: [Color("firstGradientColor"), Color("secondGradientColor")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("appstore")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .frame(width: 200, height: 200)
                    
                    Spacer()
                    
                    Text("Become a Premium Now")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                        .padding([.horizontal, .bottom], 10)
                    
                    Text("What's included?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Get to see all 21 Dinosours")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Hear how dinosours sounded")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Save all dinosour images on your phone")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("See all dinasours places in the map")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    if currentOffering != nil {
                        ForEach(currentOffering!.availablePackages) { pkg in
                            Button {
                                
                                Purchases.shared.purchase(package: pkg) { (transaction, customerInfo, error, userCancelled) in
                                    
                                    if customerInfo?.entitlements["Pro"]?.isActive == true {
                                        // Unlock that great "pro" content
                                        
                                        paywallViewModel.isSubsriptionActive = true
                                        paywallViewModel.isPaywallPresented = false
                                    }
                                }
                                
                                
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 55)
                                        .foregroundStyle(LinearGradient(stops: [.init(color: Color("Paywall2"), location: 0), .init(color: Color("Paywall1"), location: 1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .shadow(color: .white, radius: 5)
                                    
                                    Text("Become Premium Now For Only \(pkg.storeProduct.localizedPriceString)")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Button {
                        Purchases.shared.restorePurchases { ( customerInfo, error ) in
                            
                            paywallViewModel.isSubsriptionActive =  customerInfo?.entitlements.all["Pro"]?.isActive == true
                        }
                    } label: {
                        Text("Restore Purchases")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .padding(.vertical, 10)
                            .foregroundStyle(.white)
                    }
                    
                    
                    Spacer()
                }
                .onAppear {
                    Purchases.shared.getOfferings { offerings, error in
                        
                        if let offer = offerings?.current, error == nil {
                            
                            currentOffering = offer
                        }
                    }
                }
            }
            .frame(width: geo.size.width)
        }
    }
}

#Preview {
    Paywall()
        .preferredColorScheme(.dark)
        .environment(PaywallViewModel())
}
