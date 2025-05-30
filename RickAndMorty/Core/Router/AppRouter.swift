//
//  AppRouter.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

// MARK: - View Factory Protocol
protocol ViewFactory {
    func makeView() -> AnyView
}

// MARK: - Routable
typealias Routable = ViewFactory & Hashable

// MARK: - Navigation Coordinator Protocol
protocol NavigationCoordinator {
    func push(_ path: any Routable)
    func pop()
    func popToRoot()
}

// MARK: - App Router Class
final class AppRouter: ObservableObject, NavigationCoordinator {
    @Published var paths = NavigationPath()
    
    func push(_ router: any Routable) {
        DispatchQueue.main.async { [weak self] in
            let wrappedRouter = AnyRoutable(router)
            self?.paths.append(wrappedRouter)
        }
    }
    
    func pop() {
        DispatchQueue.main.async { [weak self] in
            self?.paths.removeLast()
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async { [weak self] in
            self?.paths.removeLast(self?.paths.count ?? 0)
        }
    }
    
    func resolveInitialRouter() -> any Routable {
        let mainTabViewRouter: TabViewRouter = TabViewRouter(rootCoordinator: self)
        return mainTabViewRouter
    }
}

// MARK: - Custom Navigation View
struct CustomNavigationView: View {
    @StateObject var appRouter: AppRouter
    
    var body: some View {
        NavigationStack(path: $appRouter.paths) {
            appRouter.resolveInitialRouter().makeView()
                .navigationDestination(for: AnyRoutable.self) { factory in
                    factory.makeView()
                }
        }
    }
}

// MARK: - A type-erased wrapper for Routable

struct AnyRoutable: Routable {
    private let base: any Routable
    private let equals: (any Routable) -> Bool
    
    init<T: Routable>(_ routable: T) {
        base = routable
        equals = { other in
            guard let otherBase = other as? T else { return false }
            return routable == otherBase
        }
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
