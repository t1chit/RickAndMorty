//
//  CharacterSearchRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine
import RM_Network_Service

protocol CharacterSearchRepositoryProtocol {
    func searchCharacters(query: String) -> AnyPublisher<CharacterListDomain, NetworkError>
}
