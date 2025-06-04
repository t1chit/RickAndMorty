//
//  SearchRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI
import Swinject

final class SearchRouter {
    private let rootCoordinator: NavigationCoordinator
    private let id: UUID = UUID()
    
    @Injected
    private var fetchCharacterSearchedUseCase: FetchCharacterSearchedUseCaseProtocol
    
    init(
        rootCoordinator: NavigationCoordinator
    ) {
        self.rootCoordinator = rootCoordinator
    }
}

extension SearchRouter: Routable {
    func makeView() -> AnyView {
        let vm = DefaultSearchViewModel(
            router: self,
            fetchCharacterSearchedUseCase: fetchCharacterSearchedUseCase
        )
        let view = SearchView(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation
extension SearchRouter {
    static func == (lhs: SearchRouter, rhs: SearchRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

