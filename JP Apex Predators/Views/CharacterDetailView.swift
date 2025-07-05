//
//  CharacterDetailView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 30.09.2024.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @Environment(CharacterViewModel.self) var characterViewModel
    
    let character: CharacterModel
    
    var body: some View {
            CharacterDetail(character: character)
    }
}

#Preview {
    CharacterDetailView(character: CharacterController().movieCharacters[2])
        .environment(CharacterViewModel())
        .preferredColorScheme(.dark)
}

extension CharacterDetailView {
    
    func CharacterDetail(character: CharacterModel) -> some View {
        GeometryReader { geo in
            ScrollView {
                
                if geo.size.height > 1000 || geo.size.height < geo.size.width {
                    TabView {
                        ForEach(character.images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .imageModifiers()
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(width: UIScreen.main.bounds.width, height: 700)
                } else {
                    TabView {
                        ForEach(character.images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .imageModifiers()
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(width: UIScreen.main.bounds.width, height: 450)
                }
                
                
                VStack(alignment: .leading) {
                    Text("\(character.name): \(character.role)")
                        .font(Font.custom("Nunito", size: 25))
                        .fontWeight(.semibold)
                        .padding(.top, 2)
                    
                    //Appears in
                    Text("Appears In:")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    ForEach(character.movies, id: \.self) { movies in
                        Text("· " + movies)
                            .padding(.top, 2)
                            .font(Font.custom("OpenSans", size: 16))
                    }
                    
                    //Movie Description
                    Text("Movie Moments:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    ForEach(character.movieScenes, id: \.self) { scenes in
                        Text(scenes.movie)
                            .padding(.vertical, 2)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(scenes.sceneDescription)
                            .padding(.vertical, 2)
                            .font(Font.custom("OpenSans", size: 16))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Read more:")
                        Link(character.link, destination: URL(string: character.link)!)
                            .font(.caption)
                            .foregroundStyle(.blue.opacity(0.7))
                    }
                    .padding(.vertical, 2)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
    }
}

extension View {
    func imageModifiers() -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                LinearGradient(stops: [
                    Gradient.Stop(color: .clear, location: 0.7),
                    Gradient.Stop(color: Color("SheetBackground"), location: 1)
                ],
                               startPoint: .top,
                               endPoint: .bottom)
            }
    }
}
