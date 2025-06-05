//
//  MainTabView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI

struct MainTabView: View {
    let rootCoordinator: NavigationCoordinator
    @State private var selectedTab: Int = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            CharacterListRouter(rootCoordinator: rootCoordinator)
                .makeView()
                .tag(1)
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
            
            SearchRouter(rootCoordinator: rootCoordinator)
                .makeView()
                .tag(2)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
