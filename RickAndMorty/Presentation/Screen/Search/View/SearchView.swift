//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm: DefaultSearchViewModel
    var body: some View {
        viewStates()
            .navigationTitle("Search") 
    }
    
    private func viewStates() -> some View {
        VStack {
            SearchBarView(text: Binding(
                               get: { vm.state.query },
                               set: { vm.send(.updateQuery($0)) }
            )) {
                vm.send(.performSearch)
            }
            
            switch vm.state.phase {
            case .idle:
                Text("Start Searching...")
            case .searching:
                Text("Searching...")
            case .noResults:
                Text("No results found...")
            case .results:
                content()
            }
            
            
            Spacer()
        }
    }
    
    private func content() -> some View {
        List(vm.state.characterList?.results ?? []) { character in
            Text(character.name)
        }
    }
}


struct SearchBarView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var placeholder: String = "Search..."
    var onSubmit: (() -> Void)

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .onSubmit {
                    onSubmit()
                }
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: text)
    }
}
