//
//  ViewFactory.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 08.06.25.
//

import SwiftUI

// MARK: - View Factory Protocol
public protocol ViewFactory {
    func makeView() -> AnyView
}

// MARK: - Routable
public protocol Routable: ViewFactory, Hashable, Identifiable where ID == String {}

// MARK: - Navigation Coordinator Protocol
public protocol NavigationCoordinator {
    func push(_ path: any Routable) async
    func pop() async
    func popToRoot() async
    func present(_ router: any Routable, detents: Set<PresentationDetent>) async
    func dismissPresented()
}
