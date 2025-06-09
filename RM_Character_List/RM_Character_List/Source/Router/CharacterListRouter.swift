//
//  CharacterListRouter.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//


import SwiftUI
import RM_Core
import Swinject
import RM_Details

// MARK: - CharacterListRouter
public final class CharacterListRouter {
    private let rootCoordinator: NavigationCoordinator
    private let container: Resolver
    
    public init(
        rootCoordinator: NavigationCoordinator,
        container: Resolver,
    ) {
        self.rootCoordinator = rootCoordinator
        self.container = container
    }

    func routeToDetailPage(withID id: Int) async {
        let router = CharacterDetailRouter(rootCoordinator: rootCoordinator,
                                           container: container,
                                           characterId: id)
        await rootCoordinator.push(router)
    }
}


// MARK: - ViewFactory implementation

extension CharacterListRouter: Routable {
    public var id: String {
        "CharacterListRouter"
    }
    
    
    public func makeView() -> AnyView {
        let useCase = container.resolve(FetchCharacterListUseCaseProtocol.self)!
        let vm = DefaultCharacterListViewModel(router: self,
                                               characterListUseCase: useCase)
        let view = CharactersListView(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation
extension CharacterListRouter {
    public static func == (lhs: CharacterListRouter, rhs: CharacterListRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

