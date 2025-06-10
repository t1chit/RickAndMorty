//
//  DefaultEpisodesViewModel.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation
import Combine
import RM_Core

// MARK: - State

struct EpisodesState {
    var isLoading: Bool = false
    var episode: EpisodeDomain?
    var error: String?
    var charactersInEpisode: [EpisodesCharacterDomain] = []
}

// MARK: - Intent

enum EpisodesIntent {
    case dismiss
}

protocol EpisodesViewModel: ViewModelInput, ViewModelOutput where
        Intent == EpisodesIntent,
        State == EpisodesState {}

final class DefaultEpisodesViewModel: EpisodesViewModel, ObservableObject {
    private let router: EpisodesRouter
    private let id: Int
    
    private let fetchEpisodeDetailsUseCase: FetchEpisodeDetailUseCaseProtocol
    
    @Published var state: EpisodesState = .init()
    
    private var cancellables: Set<AnyCancellable> = []

    init(
        id: Int,
        router: EpisodesRouter,
        fetchEpisodeDetailsUseCase: FetchEpisodeDetailUseCaseProtocol
    ) {
        self.id = id
        self.router = router
        self.fetchEpisodeDetailsUseCase = fetchEpisodeDetailsUseCase
        fetchEpisodeDetails()
    }
    
    func send(_ intent: EpisodesIntent) {
        switch intent {
        case .dismiss:
            router.dismiss()
        }
    }
    
    private func fetchEpisodeDetails() {
        state.isLoading = true
        state.error = nil
        state.episode = nil
        
        fetchEpisodeDetailsUseCase.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.state.error = error.localizedDescription
                    print("Catched Error In DefaultEpisodeDetailsViewModel: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.state.episode = response
                let ids = response.characters.compactMap({ $0.extractedID })
                self?.fetchCharactersInEpisode(withIDs: ids)
            }
            .store(in: &cancellables)
    }
    
    private func fetchCharactersInEpisode(withIDs ids: [Int]) {
        state.isLoading = true
        
        fetchEpisodeDetailsUseCase.executeEpisodesCharacters(withIds: ids)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                if case let .failure(error) = completion {
                    self?.state.error = error.localizedDescription
                    print("Character fetch error: \(error)")
                }
            } receiveValue: { [weak self] characters in
                self?.state.charactersInEpisode = characters
                print("Fetched characters: \(characters)")
            }
            .store(in: &cancellables)
    }
}
