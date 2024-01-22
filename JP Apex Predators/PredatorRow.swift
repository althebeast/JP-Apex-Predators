//
//  PredatorRow.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.01.2024.
//

import SwiftUI

struct PredatorRow: View {
    
    let predator: ApexPredator
    
    var body: some View {
        HStack{
            Image(predator.name.lowercased().filter { $0 != " "})
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(color: .white, radius: 1, x: 0, y: 0)
            
            VStack(alignment: .leading){
                Text(predator.name)
                    .fontWeight(.bold)
                
                Text(predator.type.capitalized)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 5)
                    .overlay{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(predator.typeOverlay().opacity(0.40))
                    }
            }
        }
    }
}

#Preview {
    PredatorRow(predator: ApexPredator(id: 3, name: "Tryannosaurus Rex", type: "land", movies: ["Jurassic Park", "Jurassic Park 2"], movieScenes: [MovieScene(id: 3, movie: "Jurassic Park III", sceneDescription: "The film starts off with Dr. Grant and his colleague Billy discussing a Velociraptor’s communicative intelligence. Billy uses a 3D printer to replicate the larynx of a Velociraptor. When Dr. Grant and the group get stranded on the island, his colleague Billy steals two Velociraptor eggs unknown to the others. When the survivors reach the abandoned laboratory, a raptor sneaks in there and attacks Amanda Kirby. The group runs to the cages and traps one of them. We see its communicative abilities when it actually calls the other Velociraptors for help. The survivors run through a group of Corythosaurus and Parasaurolophus and into the forest. Amanda, Paul and Billy hide in the trees while Dr. Grant is still on the ground. The raptors injure Udesky and set a trap to lure the others down from the tree. Amanda Kirby almost falls from the tree but is saved and Dr. Grant is confronted by a Velociraptor. Eric Kirby comes to his rescue and sprays a gas can and the raptors flee.\n\nWe then see the raptors at the climax of the movie when the survivors are making their way back to the beach. The Velociraptors surround the group and the female raptor challenges Amanda Kirby for the eggs that Billy stole earlier. She hands over the eggs and Dr. Grant uses the imitation raptor larynx to fool the raptors into running off. The survivors then escape the island.")], link: "www.google.com.tr"))
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
