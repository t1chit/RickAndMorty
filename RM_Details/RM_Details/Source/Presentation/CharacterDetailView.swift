//
//  CharacterDetailView.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//

import SwiftUI
import RM_Core

public struct CharacterDetailView: View {
    @StateObject var vm: DefaultCharacterDetailViewModel
    
    public var body: some View {
        viewStates
            .navigationTitle("Character Details")
            .task {
                vm.send(.onAppear)
            }
    }
    
    @ViewBuilder
    private var viewStates: some View {
        if vm.state.isLoading {
            loading
        } else {
            if let character = vm.state.characterDetail {
                characterDetailsView(with: character)
            } else {
                Text("Found the error \(String(describing: vm.state.error))!")
            }
        }
    }
    
    private var loading: some View {
        Text("Loading...")
    }
    
    @ViewBuilder
    private func characterDetailsView(with character: CharacterDetailDomain) -> some View {
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
                    Text("Origin: \(character.originName)")
                    Text("Current Location: \(character.locationName)")
                }
                .padding(.horizontal)
                
                Divider()
                
                // Episodes
                VStack(alignment: .leading, spacing: 8) {
                    Text("Appears in Episodes:")
                        .font(.headline)
                    ForEach(character.episodes, id: \.self) { episode in
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

