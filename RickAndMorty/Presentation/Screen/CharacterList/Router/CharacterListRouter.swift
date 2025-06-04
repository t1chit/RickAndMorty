//
//  CharacterListRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI
import Swinject
// MARK: - CharacterListRouter
final class CharacterListRouter {
    private let rootCoordinator: NavigationCoordinator
    private let id = UUID() // 👈 Unique identifier for hashing
    
    init(rootCoordinator: NavigationCoordinator) {
        self.rootCoordinator = rootCoordinator
    }
    
    func routeToDetailPage(withID id: Int) async {
        let router = CharacterDetailRouter(rootCoordinator: rootCoordinator, characterId: id)
        await rootCoordinator.push(router)
    }
}


// MARK: - ViewFactory implementation

extension CharacterListRouter: Routable {
    func makeView() -> AnyView {
        let vm = DefaultCharacterListViewModel(router: self)
        let view = CharactersListView(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation
extension CharacterListRouter {
    static func == (lhs: CharacterListRouter, rhs: CharacterListRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

