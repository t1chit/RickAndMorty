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
            if let characterDetail = vm.characterDetail {
                characterDetailsView(with: characterDetail)
            } else {
                loading()
            }
        }
    }
    
    private func loading() -> some View {
        Text("Loading...")
    }
    
    @ViewBuilder
    private func characterDetailsView(with characterDetail: CharacterDetail) -> some View {
        Text("We Have Found Character: \(characterDetail.name)")
    }
}
