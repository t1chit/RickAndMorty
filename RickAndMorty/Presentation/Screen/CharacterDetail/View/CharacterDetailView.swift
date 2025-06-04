//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var vm: CharacterDetailViewModel
    var body: some View {
        viewStates()
            .task {
                vm.send(.onAppear)
            }
    }
    
    @ViewBuilder
    private func viewStates() -> some View {
        switch vm.state.isLoading {
        case true:
            loading()
        case false:
            if let character = vm.state.characterDetail {
                characterDetailsView(with: character)
            } else {
                Text("Found the error \(String(describing: vm.state.error))!")
            }
        }
    }
    
    private func loading() -> some View {
        Text("Loading...")
    }
    
    @ViewBuilder
    private func characterDetailsView(with character: CharacterDetail) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                CachedImage(url: character.image) { phase in
                    switch  phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                    case .failure( _ ):
                        Image(systemName: "xmark.circle")
                    @unknown default:
                        fatalError()
                        
                        
                    }
                }
                // Basic Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Circle()
                            .fill(character.status == "Alive" ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        Text(character.status)
                    }
                    
                    Text("Species: \(character.species)")
                    if !character.type.isEmpty {
                        Text("Type: \(character.type)")
                    }
                    Text("Gender: \(character.gender)")
                    Text("Origin: \(character.origin.name)")
                    Text("Current Location: \(character.location.name)")
                }
                .padding(.horizontal)
                
                Divider()
                
                // Episodes
                VStack(alignment: .leading, spacing: 8) {
                    Text("Appears in Episodes:")
                        .font(.headline)
                    ForEach(character.episode, id: \.self) { episode in
                        Text(episode)
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

