//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

struct CharacterListView: View {
    @Bindable var vm: CharacterListViewModel
    var body: some View {
        Button {
            vm.navigateToDetails()
        } label: {
            Text("Click To Navigate")
        }
        .buttonStyle(PlainButtonStyle())
    }
}
