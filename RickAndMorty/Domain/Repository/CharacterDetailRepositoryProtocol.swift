//
//  CharacterDetailRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine
import RM_Network_Service

protocol CharacterDetailRepositoryProtocol {
    func fetchCharacter(id: Int)  -> AnyPublisher<CharacterDetailDomain, NetworkError>
}
