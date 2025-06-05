//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine

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
    case characterSelected(withID: Int)
    case loadMoreCharacters
}

// MARK: - Character List View Model Protocol

protocol CharacterListViewModel: ViewModelInput, ViewModelOutput where
         Intent == CharacterListIntent,
         State == CharacterListState {}

// MARK: - Character List View Model

final class DefaultCharacterListViewModel: ObservableObject {
    private let router: CharacterListRouter
    @Injected
    private var characterListUseCase: FetchCharacterUseCaseProtocol
    
    @Published var state: CharacterListState = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        router: CharacterListRouter,
    ) {
        self.router = router
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        state.isloading = true
        state.error = nil
        
        characterListUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.state.isloading = false
                if case let .failure(error) = completion {
                    self?.state.error = error.localizedDescription
                    print("Error fetching characters: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.state.characterList = response
            }
            .store(in: &cancellables)

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
    
    private func navigateToDetails(withID id: Int) async {
        await router.routeToDetailPage(withID: id)
    }
    
    func send(_ intent: CharacterListIntent) {
        switch intent {
        case .characterSelected(let id):
            Task {
                await navigateToDetails(withID: id)
            }
        case .loadMoreCharacters:
            Task {
                await fetchMoreCharacters()
            }
        }
    }
}
