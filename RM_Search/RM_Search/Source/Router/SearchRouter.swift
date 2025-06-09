//
//  SearchRouter.swift
//  RM_Search
//
//  Created by Temur Chitashvili on 09.06.25.
//


import SwiftUI
import Swinject
import RM_Core
import RM_Details

public final class SearchRouter {
    private let rootCoordinator: NavigationCoordinator
    private let container: Resolver
    
    public init(
        rootCoordinator: NavigationCoordinator,
        container: Resolver
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

extension SearchRouter: Routable {
    public var id: String {
        "SearchRouter"
    }
    
    public func makeView() -> AnyView {
        let useCase = container.resolve(FetchCharacterSearchedUseCaseProtocol.self)!
        let vm = DefaultSearchViewModel(
            router: self,
            fetchCharacterSearchedUseCase: useCase
        )
        let view = SearchView(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation
extension SearchRouter {
    public static func == (lhs: SearchRouter, rhs: SearchRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

