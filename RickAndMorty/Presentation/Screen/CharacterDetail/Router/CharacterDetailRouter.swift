//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

final class CharacterDetailRouter {
    private let rootCoordinator: NavigationCoordinator
    private let id = UUID() // 👈 Unique identifier for hashing

    init(rootCoordinator: NavigationCoordinator) {
        self.rootCoordinator = rootCoordinator
    }
    
}

// MARK: - ViewFactory implementation

extension CharacterDetailRouter: Routable {
    func makeView() -> AnyView {
        let vm = CharacterDetailViewModel()
        let view = CharacterDetailView(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation

extension CharacterDetailRouter {
    static func == (lhs: CharacterDetailRouter, rhs: CharacterDetailRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
