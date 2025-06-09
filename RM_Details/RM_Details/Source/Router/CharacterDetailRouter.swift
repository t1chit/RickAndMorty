//
//  CharacterDetailRouter.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//


import SwiftUI
import Swinject
import RM_Core

public final class CharacterDetailRouter {
    private let rootCoordinator: NavigationCoordinator
    private let id = UUID() // 👈 Unique identifier for hashing
    private let container: Resolver
    let characterId: Int
        
    public init(
        rootCoordinator: NavigationCoordinator,
        container: Resolver,
        characterId: Int,
    ) {
        self.rootCoordinator = rootCoordinator
        self.container = container
        self.characterId = characterId
    }
}

// MARK: - ViewFactory implementation

extension CharacterDetailRouter: Routable {
    public func makeView() -> AnyView {
        let useCase = container.resolve(CharacterDetailUseCaseProtocol.self)!
        let vm = DefaultCharacterDetailViewModel(id: characterId,
                                                 router: self,
                                                 characterDetailUseCase: useCase)
        let view = CharacterDetailView(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation

extension CharacterDetailRouter {
    public static func == (lhs: CharacterDetailRouter, rhs: CharacterDetailRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
