//
//  SearchViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import SwiftUI

// MARK: - Searching Phase

enum SearchPhase {
    case idle           // Start Searching
    case searching      // While request is in progress
    case noResults      // Search complete, no results found
    case results        // Search complete, results available
}

// MARK: - State

struct SearchState {
    var query: String = ""
    var characterList: CharactersList? = nil
    var error: String? = nil
    var phase: SearchPhase = .idle
}

// MARK: - Intent

enum SearchIntent {
    case updateQuery(String)
    case performSearch
}

// MARK: - Search View Model Protocol
protocol SearchViewModel: ViewModelInput, ViewModelOutput where
         Intent == SearchIntent,
         State == SearchState {}

// MARK: - Search View Model

@Observable
final class DefaultSearchViewModel: SearchViewModel {
    private let router: SearchRouter
    private let fetchCharacterSearchedUseCase: FetchCharacterSearchedUseCaseProtocol
    var state: SearchState = .init()
    
    
    init(
        router: SearchRouter,
        fetchCharacterSearchedUseCase: FetchCharacterSearchedUseCaseProtocol,
    ) {
        self.router = router
        self.fetchCharacterSearchedUseCase = fetchCharacterSearchedUseCase
    }
    
    @MainActor
    private func search() async {
        state.characterList = nil
        state.phase = .searching
        state.error = nil
        
        do {
            let response = try await fetchCharacterSearchedUseCase.execute(query: state.query)
            state.characterList = response
            state.phase = .results
        } catch {
            state.error = error.localizedDescription
            state.phase = .noResults
            print("Error catched while searching data \(error)")
        }
    }
    
    func send(_ intent: SearchIntent) {
        switch intent {
        case .updateQuery(let query):
            state.query = query
            if query.isEmpty {
                state.phase = .idle
                state.characterList = nil
            }

        case .performSearch:
            Task {
                await search()
            }
        }
    }
}

