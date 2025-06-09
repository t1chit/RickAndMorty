//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    @StateObject private var appRouter: AppRouter = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appRouter.paths) {
                appRouter.resolveInitialRouter().makeView()
                    .navigationDestination(for: AnyRoutable.self) { factory in
                        factory.makeView()
                    }
                    .sheet(item: $appRouter.presentedRouter) { factory in
                        factory.makeView()
                            .presentationDetents(factory.detents)
                    }
            }
        }
    }
}
