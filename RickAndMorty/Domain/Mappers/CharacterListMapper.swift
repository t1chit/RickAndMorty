//
//  CharacterListMapper.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 06.06.25.
//

import Foundation

protocol CharacterListMapper: MapperFromDTOToDomain where
        DTO == CharactersListDTO,
        Domain == CharacterListDomain { }

final class DefaultCharacterListMapper: CharacterListMapper {
    func map(
        from dto: CharactersListDTO
    ) -> CharacterListDomain {
        let characters = dto.results.map { characterDTO in
            CharacterDetailDomain(
                id: characterDTO.id,
                name: characterDTO.name,
                image: characterDTO.image,
                gender: characterDTO.gender
            )
        }
        return CharacterListDomain(
            characterList: characters,
            nextPage: dto.info.next
        )
    }
}
