//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

@Observable
final class CharacterListViewModel {
    let router: CharacterListRouter
    
    init(router: CharacterListRouter) {
        self.router = router
    }
    
    func navigateToDetails() {
        router.routeToDetailPage()
    }
}
