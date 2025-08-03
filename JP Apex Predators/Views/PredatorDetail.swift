//
//  PredatorDetail.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 25.01.2024.
//

import SwiftUI
import MapKit
import TipKit
import Subsonic
import StoreKit

struct PredatorDetail: View {
    
    let predator: ApexPredator
    let imageTip = DetailTip()
    
    @State var position: MapCameraPosition
    @State private var animateSound = false
    @State private var dragAmount = CGSize.zero
    
    @Environment(\.requestReview) var requestReview
    @Environment(PaywallViewModel.self) var paywallViewModel
    
    var body: some View {
        
        @Bindable var vm = paywallViewModel
        
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .bottomTrailing) {
                    // Background
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                        }

                    // Dino Image with interactive 3D effect
                    NavigationLink {
                        withAnimation {
                            VStack {
                                HStack {
                                    Image(predator.image)
                                        .resizable()
                                        .scaledToFit()
                                        .scaleEffect(x: -1)
                                    VStack(alignment: .trailing) {
                                        Button {
                                            if paywallViewModel.isSubsriptionActive {
                                                let imageSaver = ImageSaver()
                                                imageSaver.writeToPhotoAlbum(image: UIImage(named: predator.image)!)
                                            } else {
                                                paywallViewModel.isPaywallPresented = true
                                            }
                                        } label: {
                                            Image(systemName: "arrow.down.circle.fill")
                                                .font(.title)
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                        }
                    } label: {
                        GeometryReader { geo in
                            ZStack {
                                Image(predator.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: geo.size.height > geo.size.width ? geo.size.width / 1.5 : geo.size.width / 1.8,
                                        height: geo.size.height > geo.size.width ? geo.size.height / 3 : geo.size.height / 1.4
                                    )
                                    .scaleEffect(x: -1)
                                    // Interactive 3D rotation based on drag
                                    .rotation3DEffect(
                                        .degrees(Double(dragAmount.height) / 10),
                                        axis: (x: 1, y: 0, z: 0)
                                    )
                                    .rotation3DEffect(
                                        .degrees(Double(-dragAmount.width) / 10),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                    .scaleEffect(1.05)
                                    .shadow(color: .black.opacity(0.8), radius: 10, x: 0, y: 10)
                                    .shadow(color: .gray.opacity(0.3), radius: 5, x: -5, y: -5)
                                    .offset(y: 20)
                                    .animation(.easeOut(duration: 0.3), value: dragAmount)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                dragAmount = value.translation
                                            }
                                            .onEnded { _ in
                                                dragAmount = .zero
                                            }
                                    )
                            }
                            .frame(maxWidth: .infinity, maxHeight: geo.size.height > geo.size.width ? geo.size.height / 3 + 40 : geo.size.height / 1.4 + 40)
                            .contentShape(Rectangle()) // To ensure whole area is tappable
                        }
                        .frame(height:  geo.size.height > geo.size.width ? geo.size.height / 3 + 40 : geo.size.height / 1.4 + 40)
                    }
                    .popoverTip(imageTip, arrowEdge: .trailing)
                }
                .task {
                    try? Tips.configure()
                }
                
                VStack(alignment: .leading){
                    // Dino name
                    HStack {
                        Text(predator.name)
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        if predator.sound.sounds != nil {
                            Button {
                                if paywallViewModel.isSubsriptionActive {
                                    play(sound: "\(predator.sound.sounds ?? "velociraptor.mp3")")
                                } else {
                                    paywallViewModel.isPaywallPresented = true
                                }
                            } label: {
                                Image(systemName: "waveform")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .shadow(color: .green.opacity(0.7), radius: animateSound ? 20 : 5)
                                    .scaleEffect(animateSound ? 1.2 : 1)
                                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateSound)
                            }
                            .onAppear {
                                animateSound = true
                            }
                        } else {
                            
                        }
                    }
                    
                    //Current location
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location,
                                                                distance: 1000,
                                                                heading: 250,
                                                                pitch: 80)))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomLeadingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    Group {
                        sectionTitle("Dinosaur Characteristics")
                        ForEach(predator.specs, id: \.self) { spec in
                            bulletPoint(spec)
                        }
                    }
                    
                    Group {
                        sectionTitle("Appears In")
                        ForEach(predator.movies, id: \.self) { movie in
                            bulletPoint(movie)
                        }
                    }
                    
                    Group {
                        sectionTitle("Movie Moments")
                        ForEach(predator.movieScenes, id: \.self) { scene in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(scene.movie)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                Text(scene.sceneDescription)
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal)
                            }
                            .padding(.vertical, 5)
                            .background(Color("CardBackground").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.6), radius: 5, x: 0, y: 3)
                            .transition(.opacity.combined(with: .slide))
                        }
                    }
                    
                    Group {
                        sectionTitle("Read More")
                        Link(destination: URL(string: predator.link)!) {
                            Text(predator.link)
                                .font(.caption)
                                .underline()
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .foregroundColor(.white)
                .animation(.easeInOut, value: predator)
            }
        }
    }
}

@ViewBuilder
func sectionTitle(_ text: String) -> some View {
    Text(text)
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundColor(.white.opacity(0.9))
        .padding(.vertical, 5)
}

@ViewBuilder
func bulletPoint(_ text: String) -> some View {
    HStack(alignment: .top, spacing: 8) {
        Text("•")
            .font(.headline)
            .foregroundColor(.green)
        Text(text)
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.85))
            .fixedSize(horizontal: false, vertical: true)
    }
    .padding(.vertical, 2)
}
    
    #Preview {
        NavigationStack{
            PredatorDetail(predator: PredatorController().apexPredators[2], position: .camera(MapCamera(centerCoordinate: PredatorController().apexPredators[2].location, distance: 30000)))
                .preferredColorScheme(.dark)
                .environment(PaywallViewModel())
        }
    }
