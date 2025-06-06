//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine
import RM_Network_Service

protocol CharacterListRepositoryProtocol {
    func fetchCharacterList() -> AnyPublisher<CharacterListDomain, NetworkError>
    func fetchMoreCharacters(page: Int) -> AnyPublisher<CharacterListDomain, NetworkError>
}
