//
//  CharacterSearchRepositoryProtocol.swift
//  RM_Search
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation
import Combine
import RM_Network_Service
import RM_Core

protocol CharacterSearchRepositoryProtocol {
    func searchCharacters(query: String) -> AnyPublisher<CharacterListDomain, NetworkError>
}
