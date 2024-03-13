//
//  PlayerCardView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI
import _MapKit_SwiftUI

struct PredatorCardView: View {
    
    @Environment (ViewModel.self) var viewModel
    
    let predator: [ApexPredator]
    
    var body: some View {
        ForEach(predator) { predator in
            VStack {
                NavigationLink(destination: PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 2000)))) {
                    withAnimation {
                        PredatorCard(predator: predator)
                    }
                }
            }
        }
    }
}

#Preview {
    PredatorCardView(predator: [ApexPredator]())
}
