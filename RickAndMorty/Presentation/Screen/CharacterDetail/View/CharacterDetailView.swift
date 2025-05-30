//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

struct CharacterDetailView: View {
    @Bindable var vm: CharacterDetailViewModel
    var body: some View {
        content()
        .task {
            await vm.getCharacterDetail()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    vm.navigateToCharacterList()
                }
            }
        }
    }
    
    private func content() -> some View {
        ZStack {
            if let character = vm.characterDetail {
                characterDetailsView(with: character)
            } else {
                loading()
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
                // Character Image
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 300)
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

