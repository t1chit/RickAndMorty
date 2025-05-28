//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

@Observable
final class CharacterDetailViewModel {
    let id: Int
    let router: CharacterDetailRouter
    
    init (id: Int, router: CharacterDetailRouter) {
        self.id = id
        self.router = router
    }
    
    func navigateToCharacterList() {
        router.goBack()
    }
}
