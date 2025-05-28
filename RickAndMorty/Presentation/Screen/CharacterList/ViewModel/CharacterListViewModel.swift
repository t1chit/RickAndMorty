//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

@Observable
final class CharacterListViewModel {
    private let router: CharacterListRouter
    private let characterListUseCase: FetchCharacterUseCase
    var characterList: CharactersList?
    
    init(router: CharacterListRouter, characterListUseCase: FetchCharacterUseCase) {
        self.router = router
        self.characterListUseCase = characterListUseCase
    }
    
    @MainActor
    func fetchCharacters() async {
        do {
            let response = try await characterListUseCase.execute()
            characterList = response
        }catch {
            print("Error fetching character list in view model: \(error)")
        }
    }
    
    func navigateToDetails(withID id: Int) {
        router.routeToDetailPage(withID: id)
    }
}
