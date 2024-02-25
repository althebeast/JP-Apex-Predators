//
//  ApexPredator.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import Foundation
import SwiftUI
import MapKit
import TipKit
import Subsonic

struct ApexPredator: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let type: PredatorType
    let sound: PredatorSound
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let specs: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    struct MovieScene: Decodable, Identifiable, Hashable {
        
        let id: Int
        let movie: String
        let sceneDescription: String
        
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: PredatorType {
        self
    }
    
    var background: Color {
        switch self {
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        case .all:
            .black
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}


enum PredatorSound: String, Decodable {
    case velociraptor
    case brachiosaurus
    case tyrannosaurusrex
    case dilophosaurus
    case compsognathus
    case stegosaurus
    case pachycephalosaurus
    case pteranodon
    case spinosaurus
    case indominusrex
    case mosasaurus
    case dimorphodon
    case baryonyx
    case carnotaurus
    case allosaurus
    case indoraptor
    case quetzalcoatlus
    case giganotosaurus
    case atrociraptor
    case therizinosaurus
    case pyroraptor
    
    var sounds: String? {
        switch self {
        case .velociraptor:
            "velociraptor.mp3"
        case .brachiosaurus:
            "brachiosaurus.mp3"
        case .tyrannosaurusrex:
            "tyrannosaurusrex.mp3"
        case .dilophosaurus:
            "dilophosaurus.mp3"
        case .compsognathus:
            "compsognathus.mp3"
        case .stegosaurus:
            "stegosaurus.mp3"
        case .pachycephalosaurus:
            "pachycephalosaurus.mp3"
        case .pteranodon:
            "pteranodon.mp3"
        case .spinosaurus:
            "spinosaurus.mp3"
        case .indominusrex:
            nil
        case .mosasaurus:
            nil
        case .dimorphodon:
            "dimorphodon.mp3"
        case .baryonyx:
            nil
        case .carnotaurus:
            "carnotaurus.mp3"
        case .allosaurus:
            "allosaurus.mp3"
        case .indoraptor:
            "indoraptor.mp3"
        case .quetzalcoatlus:
            nil
        case .giganotosaurus:
            "giganotosaurus.mp3"
        case .atrociraptor:
            nil
        case .therizinosaurus:
            nil
        case .pyroraptor:
            nil
        }
    }
    
}
