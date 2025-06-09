//
//  MainTabView.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI
import RM_Core
import RM_Character_List
import RM_Search
import Swinject

struct MainTabView: View {
    let rootCoordinator: NavigationCoordinator
    let container: Resolver
    @State private var selectedTab: Int = 1
    var body: some View {
        TabView {
            CharacterListRouter(rootCoordinator: rootCoordinator,
                                container: container)
                .makeView()
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
            
            SearchRouter(rootCoordinator: rootCoordinator,
                         container: container)
                .makeView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
