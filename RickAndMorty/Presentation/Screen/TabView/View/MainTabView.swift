//
//  MainTabView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI

struct MainTabView: View {
    //    @Bindable var viewModel: MainTabViewViewModel
    let rootCoordinator: NavigationCoordinator
    
    var body: some View {
        TabView {
            CharacterListRouter(rootCoordinator: rootCoordinator).makeView()
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
        }
    }
}
