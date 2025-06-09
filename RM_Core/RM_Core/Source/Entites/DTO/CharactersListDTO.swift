//
//  CharactersListDTO.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation

public struct CharactersListDTO: Decodable {
    public let info: InfoDTO
    public var results: [CharacterDetailDTO]
    
    public  init(
        info: InfoDTO,
        results: [CharacterDetailDTO]
    ) {
        self.info = info
        self.results = results
    }
}
