//
//  SearchView.swift
//  RM_Search
//
//  Created by Temur Chitashvili on 09.06.25.
//

import SwiftUI
import RM_Core

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
        }
        .listStyle(.plain)
    }
}


struct SearchBarView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var placeholder: String = "Search..."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
              
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
struct CharacterSearchCard: View {
    let character: CharacterCardDomain
    
    var body: some View {
        content()
    }
    
    private func content() -> some View {
        HStack(alignment: .top, spacing: 16) {
            image()
            
            characterContent()
                .padding(.top, 8)
        }
    }
    
    private func image() -> some View {
        CachedImage(url: character.image) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 80, height: 80)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(12)
            case .failure:
                Image(systemName: "xmark.circle")
                    .frame(width: 80, height: 80)
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func characterContent() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(character.name)
                .font(.headline)
                .lineLimit(1)
            
            Text(character.gender)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }
}
