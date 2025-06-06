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
        TabView {
            CharacterListRouter(rootCoordinator: rootCoordinator)
                .makeView()
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
            
            SearchRouter(rootCoordinator: rootCoordinator)
                .makeView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
