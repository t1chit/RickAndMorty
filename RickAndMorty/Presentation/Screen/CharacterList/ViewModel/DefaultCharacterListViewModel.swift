//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

// MARK: - State

struct CharacterListState {
    var isloading: Bool = false
    var characterList: CharactersList?
    var moreCharactersAreLoading: Bool = false
    var error: String?
    var page: Int = 1
}

// MARK: - Intent

enum CharacterListIntent {
    case onAppear
    case characterSelected(withID: Int)
    case loadMoreCharacters
}

// MARK: - Character List View Model Protocol

protocol CharacterListViewModel: ViewModelInput, ViewModelOutput where
         Intent == CharacterListIntent,
         State == CharacterListState {}

// MARK: - Character List View Model

@Observable
final class DefaultCharacterListViewModel {
    private let router: CharacterListRouter
    private let characterListUseCase: FetchCharacterUseCaseProtocol
    
    var state: CharacterListState = .init()
    
    init(
        router: CharacterListRouter,
        characterListUseCase: FetchCharacterUseCaseProtocol
    ) {
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
    
    @MainActor
    private func fetchMoreCharacters() async {
        state.moreCharactersAreLoading = true
        state.error = nil
        state.page += 1
            
        do {
            let response = try await characterListUseCase.execute(page: state.page)
            state.characterList?.results.append(contentsOf: response.results)
            
        } catch {
            state.error = error.localizedDescription
            print("Can not fetch more characters: \(error)")
        }
        
        state.moreCharactersAreLoading = false
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
            
        case .loadMoreCharacters:
            Task {
                await fetchMoreCharacters()
            }
        }
    }
}
