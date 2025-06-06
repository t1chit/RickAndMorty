//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine

protocol CharacterListRepositoryProtocol {
    func fetchCharacterList() -> AnyPublisher<CharacterListDomain, NetworkError>
    func fetchMoreCharacters(page: Int) -> AnyPublisher<CharacterListDomain, NetworkError>
}
