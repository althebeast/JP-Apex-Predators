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
                    
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                        Text("Hear how dinosours sounded")
                    }
                    
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                        Text("Save all dinosour images on your phone")
                    }
                    
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                        Text("Read about Jurassic Park movie chacters")
                    }
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
                            }
                        }
                        .padding(.horizontal)
                    }
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
    }
}

#Preview {
    Paywall()
        .preferredColorScheme(.dark)
        .environment(PaywallViewModel())
}
