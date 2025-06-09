//
//  SearchView.swift
//  RM_Search
//
//  Created by Temur Chitashvili on 09.06.25.
//

import SwiftUI
import RM_Core
import RM_UI_Components

struct SearchView: View {
    @StateObject var vm: DefaultSearchViewModel
    var body: some View {
        viewStates
            .navigationTitle("Search") 
    }
    
    private var viewStates: some View {
        VStack {
            SearchBarView(text: $vm.query)
            
            switch vm.state.phase {
            case .idle:
                Text("Start Searching...")
            case .searching:
                Text("Searching...")
            case .noResults:
                Text("No results found...")
            case .results:
                content
            }
            
            
            Spacer()
        }
    }
    
    private var content: some View {
        List(vm.state.characterList?.characterList ?? []) { character in
            CharacterSearchCard(character: character)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .onTapGesture {
                    vm.send(.characterSelected(withID: character.id))
                }
        }
        .listStyle(.plain)
    }
}
