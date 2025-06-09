//
//  EpisodesRouter.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import SwiftUI
import Swinject
import RM_Core

public final class EpisodesRouter {
    private let rootCoordinator: NavigationCoordinator
    private let container: Resolver
    private let episodeID: Int
    
    public init(
        rootCoordinator: NavigationCoordinator,
        container: Resolver,
        episodeID: Int
    ) {
        self.rootCoordinator = rootCoordinator
        self.container = container
        self.episodeID = episodeID
    }
    
    
    func dismiss() {
        rootCoordinator.dismissPresented()
    }
}

extension EpisodesRouter: Routable {
    public var id: String {
        "EpisodesRouter-\(episodeID)"
    }
    

    public func makeView() -> AnyView {
        let useCase: FetchEpisodeDetailUseCaseProtocol = container.resolve(FetchEpisodeDetailUseCaseProtocol.self)!
        let vm: DefaultEpisodesViewModel = DefaultEpisodesViewModel(
            id: episodeID,
            router: self,
            fetchEpisodeDetailsUseCase: useCase
        )
        let view: EpisodesView = .init(vm: vm)
        return AnyView(view)
    }
}

// MARK: - Hashable implementation
extension EpisodesRouter {
    public static func == (lhs: EpisodesRouter, rhs: EpisodesRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

