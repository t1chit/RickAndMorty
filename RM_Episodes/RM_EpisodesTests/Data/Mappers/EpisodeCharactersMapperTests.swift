//
//  EpisodeCharactersMapperTests.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 10.06.25.
//

import Testing
import RM_Core
@testable import RM_Episodes

struct EpisodeCharactersMapperTests {
    @Test func map_FromValidCharacterDetailDTO_returnsCorrectEpisodeCharacterDomainModel() {
        let dto = CharacterDetailDTO(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationDTO(name: "Earth", url: "Example URL"),
            location: LocationDTO(name: "Earth", url: "Example URL"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z"
        )

        
        let mapper: DefaultEpisodeCharactersMapper = .init()
        
        let episodeCharacterDomain = mapper.map(from: dto)
        
        #expect(episodeCharacterDomain.id == dto.id)
        #expect(episodeCharacterDomain.image == dto.image)
        #expect(episodeCharacterDomain.name == dto.name)
    }
}
