//
//  CharactersListView.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//


import SwiftUI
import RM_Core
import RM_UI_Components

public struct CharactersListView: View {
    @StateObject var vm: DefaultCharacterListViewModel
    
    public var body: some View {
        viewStates
            .navigationTitle("Characters")
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private var viewStates: some View {
        if vm.state.isloading {
            Text("Loading...")
        } else {
            if vm.state.characterList == nil {
                Text("Found the error \(String(describing: vm.state.error))!")
            } else {
                VStack(spacing: 8) {
                    content
                    
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
    
    private var content: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(vm.state.characterList?.characterList ?? []) { character in
                    CharacterCard(character: character)
                        .onTapGesture {
                            vm.send(.characterSelected(withID: character.id))
                        }
                        .onAppear {
                            guard let id = vm.state.characterList?.characterList.last?.id else { return }
                            
                            if character.id == id {
                                vm.send(.loadMoreCharacters)
                            }
                        }
                }
            }
        }
    }
}
