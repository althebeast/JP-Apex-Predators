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
    
    @State private var isPurchasing = false
    @State private var selectedPackageId: String?

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color("firstGradientColor"), Color("secondGradientColor")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Spacer()
                    
                    // App Icon or Illustration
                    Image("appstore")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: .black.opacity(0.4), radius: 12, x: 0, y: 8)
                        .padding(.top)
                    
                    // Title
                    Text("Unlock Premium")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 1)
                    
                    // Subtitle
                    Text("Get access to all dinosaurs, sounds, images, and maps!")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 30)
                    
                    // Benefits List
                    benefitsList
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // Purchase buttons
                    if let offering = currentOffering {
                        VStack(spacing: 15) {
                            ForEach(offering.availablePackages) { package in
                                purchaseButton(for: package)
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    
                    // Restore Purchases
                    Button(action: restorePurchases) {
                        Text("Restore Purchases")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 10)
                    }
                    
                    Spacer(minLength: 30)
                }
                .frame(width: geo.size.width)
            }
            .onAppear(perform: loadOfferings)
        }
    }
    
    // MARK: - Benefits List View
    var benefitsList: some View {
        VStack(alignment: .leading, spacing: 16) {
            benefitRow(icon: "checkmark.seal.fill", text: "Unlock all 21 dinosaurs")
            benefitRow(icon: "checkmark.seal.fill", text: "Hear authentic dinosaur sounds")
            benefitRow(icon: "checkmark.seal.fill", text: "Save images directly to your device")
            benefitRow(icon: "checkmark.seal.fill", text: "Explore dinosaurs’ locations on the map")
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 5)
    }
    
    // Benefit row helper
    func benefitRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.title3)
            Text(text)
                .foregroundColor(.white.opacity(0.9))
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
    }
    
    // MARK: - Purchase Button View
    func purchaseButton(for package: Package) -> some View {
        Button {
            purchase(package: package)
        } label: {
            Text("Unlock Premium for \(package.storeProduct.localizedPriceString)")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: selectedPackageId == package.identifier
                            ? [Color("Paywall2").opacity(0.85), Color("Paywall1").opacity(0.85)]
                            : [Color("Paywall1"), Color("Paywall2")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
                .scaleEffect(selectedPackageId == package.identifier ? 1.05 : 1)
                .animation(.easeInOut(duration: 0.25), value: selectedPackageId)
        }
        .disabled(isPurchasing)
    }
    
    // MARK: - Load Offerings
    func loadOfferings() {
        Purchases.shared.getOfferings { offerings, error in
            if let offer = offerings?.current, error == nil {
                currentOffering = offer
            }
        }
    }
    
    // MARK: - Purchase Handling
    func purchase(package: Package) {
        isPurchasing = true
        selectedPackageId = package.identifier
        
        Purchases.shared.purchase(package: package) { transaction, customerInfo, error, userCancelled in
            isPurchasing = false
            selectedPackageId = nil
            
            if let customerInfo = customerInfo,
               customerInfo.entitlements["Pro"]?.isActive == true {
                paywallViewModel.isSubsriptionActive = true
                paywallViewModel.isPaywallPresented = false
            }
        }
    }
    
    // MARK: - Restore Purchases
    func restorePurchases() {
        Purchases.shared.restorePurchases { customerInfo, error in
            if let customerInfo = customerInfo {
                paywallViewModel.isSubsriptionActive = customerInfo.entitlements.all["Pro"]?.isActive == true
            }
        }
    }
}

#Preview {
    Paywall()
        .preferredColorScheme(.dark)
        .environment(PaywallViewModel())
}
