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
        viewStates()
            .task {
                vm.send(.onAppear)
            }
    }
    
    @ViewBuilder
    private func viewStates() -> some View {
        switch vm.state.isloading {
        case true:
            Text("Loading...")
        case false:
            if vm.state.characterList == nil {
                Text("Found the error \(String(describing: vm.state.error))!")
            } else {
                content()
            }
        }
    }
    
    private func content() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(vm.state.characterList?.results ?? []) { character in
                    CharacterCard(character: character)
                        .onTapGesture {
                            vm.send(.characterSelected(withID: character.id))
                        }
                }
            }
        }
    }
}

// MARK: - Character Card
struct CharacterCard: View {
    let character: CharacterDetail
    
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
