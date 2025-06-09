//
//  TabViewRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI
import RM_Core
import Swinject

final class TabViewRouter {
    private let rootCoordinator: NavigationCoordinator
    private let container: Resolver

    init(
        rootCoordinator: NavigationCoordinator,
        container: Resolver,
    ) {
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
}

// MARK: - ViewFactory implementation

extension TabViewRouter: Routable {
    public var id: String {
        "TabViewRouter"
    }
    
    func makeView() -> AnyView {
        let view = MainTabView(rootCoordinator: rootCoordinator,
                               container: container)
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
