//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

struct CharactersListView: View {
    @Bindable var vm: CharacterListViewModel
    
    var body: some View {
        content()
            .task {
                await vm.fetchCharacters()
            }
    }
    
    private func content() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(vm.characterList?.results ?? []) { character in
                    CharacterCard(character: character)
                        .onTapGesture {
                            print("Navigate To Character Details Called")
                            vm.navigateToDetails(withID: character.id)
                        }
                }
            }
        }
    }
}

// MARK: - Character Card
struct CharacterCard: View {
    let character: Character
    
    var body: some View {
        content()
    }
    
    private func content() -> some View {
        VStack(alignment: .leading,
               spacing: 8) {
            image()
            
            characterContent()
        }
    }
    
    private func image() -> some View {
        AsyncImage(url: URL(string: character.image)) { image in
            image
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(16)
        } placeholder: {
            ProgressView()
        }
        
    }
    
    private func characterContent() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            
            Text(character.name)
                .font(.headline)
            
            HStack {
                Text(character.gender)
                    .foregroundColor(.secondary)
            }
        }
    }
}
