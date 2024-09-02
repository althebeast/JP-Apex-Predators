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
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        
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
                    
                    //Dino Image
                    NavigationLink{
                        withAnimation {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                            .scaleEffect(x: -1)
                        }
                    } label: {
                        if geo.size.height > geo.size.width {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                                .scaleEffect(x: -1)
                                .shadow(color: .black, radius: 7)
                                .offset(y: 20)
                        } else {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/1.8, height: geo.size.height/1)
                                .scaleEffect(x: -1)
                                .shadow(color: .black, radius: 7)
                                .offset(y: 20)
                        }
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
                                play(sound: "\(predator.sound.sounds ?? "velociraptor.mp3")")
                            } label: {
                                Image(systemName: "waveform")
                                    .font(.largeTitle)
                            }
                        } else {
                            
                        }
                    }
                    
                        BannerAd(unitID: "ca-app-pub-3940256099942544/2435281174")
                        .frame(maxWidth: .infinity, minHeight: 70)
                        .padding()
                    
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
                    
                    //dinosaur characteristics
                    Text("Dinosaur Characteristics:")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.specs, id: \.self) { specs in
                        Text("•" + specs)
                            .font(.subheadline)
                    }
                    
                    //Appears in
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    //Movie moments
                        Text("Movie Moments")
                            .font(.title)
                            .padding(.top, 15)
                        
                        ForEach(predator.movieScenes, id: \.self) {scene in
                            Text(scene.movie)
                                .font(.title2)
                                .bold()
                                .padding(.vertical, 1)
                            
                            Text(scene.sceneDescription)
                                .padding(.bottom, 15)
                        }
                        
                        //Link to webpage
                        Text("Read More:")
                            .font(.caption)
                        
                        Link(predator.link, destination: URL(string: predator.link)!)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    
                    BannerAd(unitID: "ca-app-pub-3940256099942544/2435281174")
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .padding(.top)
                    
                    }
                    .padding()
                    .padding(.bottom, 135)
                    .frame(width: geo.size.width, alignment: .leading)
                    .onAppear {
//                        requestReview()
                    }
                }
                .ignoresSafeArea()
            }
            .toolbarBackground(.automatic)
        }
    }
    
    #Preview {
        NavigationStack{
            PredatorDetail(predator: PredatorController().apexPredators[2], position: .camera(MapCamera(centerCoordinate: PredatorController().apexPredators[2].location, distance: 30000)))
                .preferredColorScheme(.dark)
        }
    }
