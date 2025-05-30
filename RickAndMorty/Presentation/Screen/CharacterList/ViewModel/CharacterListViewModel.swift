//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

struct CharacterListState {
    var isloading: Bool = false
    var characterList: CharactersList?
    var error: String?
}

enum CharacterListIntent {
    case onAppear
    case characterSelected(withID: Int)
}

@Observable
final class CharacterListViewModel {
    private let router: CharacterListRouter
    private let characterListUseCase: FetchCharacterUseCase

    var state = CharacterListState()

    init(router: CharacterListRouter, characterListUseCase: FetchCharacterUseCase) {
        self.router = router
        self.characterListUseCase = characterListUseCase
    }
    
    @MainActor
    private func fetchCharacters() async {
        state.isloading = true
        state.error = nil
        do {
            let response = try await characterListUseCase.execute()
            state.characterList = response
        } catch {
            state.error = error.localizedDescription
            print("Error fetching character list in view model: \(error)")
        }
        state.isloading = false
    }
    
    private func navigateToDetails(withID id: Int) {
        router.routeToDetailPage(withID: id)
    }
    
    func send(_ intent: CharacterListIntent) {
        switch intent {
        case .onAppear:
            Task {
                await fetchCharacters()
            }
        case .characterSelected(let id):
            navigateToDetails(withID: id)
        }
    }
}
