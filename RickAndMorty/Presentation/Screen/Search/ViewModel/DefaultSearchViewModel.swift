//
//  SearchViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine
import RM_Network_Service

// MARK: - Searching Phase

enum SearchPhase {
    case idle           // Start Searching
    case searching      // While request is in progress
    case noResults      // Search complete, no results found
    case results        // Search complete, results available
}

// MARK: - State

struct SearchState {
    var characterList: CharacterListDomain? = nil
    var error: String? = nil
    var phase: SearchPhase = .idle
}

// MARK: - Intent

enum SearchIntent {
    
}

// MARK: - Search View Model Protocol
protocol SearchViewModel: ViewModelInput, ViewModelOutput where
        Intent == SearchIntent,
        State == SearchState {}

// MARK: - Search View Model

final class DefaultSearchViewModel: SearchViewModel, ObservableObject {
    private let router: SearchRouter
    @Injected
    private var fetchCharacterSearchedUseCase: FetchCharacterSearchedUseCaseProtocol
    
    @Published var state: SearchState = .init()
    @Published var query: String = ""

    private var cancellables: Set<AnyCancellable> = []
    
    init(
        router: SearchRouter,
    ) {
        self.router = router
        observeSearchCharacterQuery()
    }
    
    // Get More Info About .flatMap
    private func observeSearchCharacterQuery() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                if let query = self?.query, query.isEmpty {
                    self?.state.phase = .idle
                    self?.state.error = nil
                    self?.state.characterList = nil
                } else {
                    self?.state.phase = .searching
                    self?.state.error = nil
                }
            })
            .filter {
                !$0.isEmpty
            }
            .flatMap { [weak self] query -> AnyPublisher<CharacterListDomain, NetworkError> in
                guard let self else {
                    return Empty().eraseToAnyPublisher()
                }
                print("Executed ")
                return self.fetchCharacterSearchedUseCase.execute(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state.phase = .noResults
                    self?.state.error = error.localizedDescription
                    print("Failed to fetch characters: \(error)")
                }
            }, receiveValue: { [weak self] characters in
                self?.state.characterList = characters
                self?.state.phase = .results
            })
            .store(in: &cancellables)
    }

    
    func send(_ intent: SearchIntent) {

    }
}

