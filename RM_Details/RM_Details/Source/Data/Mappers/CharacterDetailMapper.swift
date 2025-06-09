//
//  CharacterDetailMapper.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Foundation
import RM_Core

protocol CharacterDetailMapper: MapperFromDTOToDomain where
        DTO == CharacterDetailDTO,
        Domain == CharacterDetailDomain{ }

final class DefaultCharacterDetailMapper: CharacterDetailMapper {
    func map(
        from dto: CharacterDetailDTO
    ) -> CharacterDetailDomain {
        return .init(
            id: dto.id,
            name: dto.name,
            image: dto.image,
            gender: dto.gender,
            species: dto.species,
            originName: dto.origin.name,
            type: dto.type,
            status: dto.status,
            episodes: dto.episode,
            locationName: dto.location.name
        )
    }
}
