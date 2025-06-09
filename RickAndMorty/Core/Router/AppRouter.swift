//
//  AppRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI
import RM_Core
import Swinject

// MARK: - App Router Class
final class AppRouter: ObservableObject, NavigationCoordinator {
    @Published var paths = NavigationPath()
    private let container: Resolver
    @Published var presentedRouter: AnyRoutable? = nil  // <- For modal presentation

    
    init(
        container: Resolver = DIContainer.shared.container
    ) {
        self.container = container
    }

    var count: Int { paths.count }
    
    func push(_ router: any Routable) async {
        await MainActor.run { [weak self] in
            let wrappedRouter = AnyRoutable(router)
            self?.paths.append(wrappedRouter)
        }
    }
    
    func pop() async {
        await MainActor.run { [weak self] in
            self?.paths.removeLast()
        }
    }
    
    func popToRoot() async {
        await MainActor.run { [weak self] in
            self?.paths.removeLast(self?.paths.count ?? 0)
        }
    }
    
    func present(_ router: any Routable, detents: Set<PresentationDetent> = [.large]) async {
        await MainActor.run { [weak self] in
            let wrappedRouter = AnyRoutable(router, detents: detents)
            self?.presentedRouter = wrappedRouter
        }
    }

    func dismissPresented() {
        presentedRouter = nil
    }
    
    func resolveInitialRouter() -> any Routable {
        let mainTabViewRouter: TabViewRouter = TabViewRouter(rootCoordinator: self, container: container)
        return mainTabViewRouter
    }
}

// MARK: - A type-erased wrapper for Routable

struct AnyRoutable: Routable, Identifiable {
    let id: String
    private let base: any Routable
    private let equals: (any Routable) -> Bool
    
    let detents: Set<PresentationDetent>

    init<T: Routable>(_ routable: T, detents: Set<PresentationDetent> = [.large]) {
        self.id = routable.id
        base = routable
        equals = { other in
            guard let otherBase = other as? T else { return false }
            return routable == otherBase
        }
        self.detents = detents
    }
    
    func makeView() -> AnyView {
        self.base.makeView()
    }
    
    func hash(into hasher: inout Hasher) {
        self.base.hash(into: &hasher)
    }
    
    static func == (lhs: AnyRoutable, rhs: AnyRoutable) -> Bool {
        lhs.equals(rhs.base)
    }
}
