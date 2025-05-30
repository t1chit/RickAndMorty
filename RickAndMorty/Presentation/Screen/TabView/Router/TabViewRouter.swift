//
//  TabViewRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI

final class TabViewRouter {
    private let rootCoordinator: NavigationCoordinator
    private let id = UUID()
    
    init(rootCoordinator: NavigationCoordinator) {
        self.rootCoordinator = rootCoordinator
    }
}

// MARK: - ViewFactory implementation

extension TabViewRouter: Routable {
    func makeView() -> AnyView {
        let view = MainTabView(rootCoordinator: rootCoordinator)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation
extension TabViewRouter {
    static func == (lhs: TabViewRouter, rhs: TabViewRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
