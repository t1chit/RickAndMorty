//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

struct CharactersListView: View {
    @Bindable var vm: DefaultCharacterListViewModel
    
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
                VStack(spacing: 8) {
                    content()
                    
                    if vm.state.moreCharactersAreLoading {
                        VStack(spacing: 4) {
                            ProgressView()
                            
                            Text("Loading more...")
                        }
                    }
                }
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
                        .onAppear {
                            guard let id = vm.state.characterList?.results.last?.id else { return }
                            
                            if character.id == id {
                                vm.send(.loadMoreCharacters)
                            }
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
        CachedImage(url: character.image) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 200)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
            case .failure( _ ):
                Image(systemName: "xmark.circle")
            @unknown default:
                fatalError()
            }
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
