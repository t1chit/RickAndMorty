//
//  CharacterListDomain.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 06.06.25.
//

import Foundation

struct CharacterListDomain: Decodable {
    var characterList: [CharacterCardDomain]
    let nextPage: String?
}


