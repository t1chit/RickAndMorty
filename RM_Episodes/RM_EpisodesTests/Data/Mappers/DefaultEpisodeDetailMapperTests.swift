//
//  DefaultEpisodeDetailMapperTests.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 10.06.25.
//

import Testing
@testable import RM_Episodes

struct DefaultEpisodeDetailMapperTests {
    @Test
    func map_fromValidEpisodeDTO_returnsCorrectEpisodeDomainModel() {
        let dto: EpisodeDTO = .init(
            id: 1,
            name: "Test Episode",
            airDate: "2025-06-10",
            episode: "Episode 1",
            characters: [
                "http://swapi.dev/api/people/1/"
            ],
            url: "http://swapi.dev/api/episodes/1/",
            created: "2025-06-10T12:00:00Z"
        )
        
        let mapper: DefaultEpisodeDetailMapper = .init()
        
        let episodeDomainModel: EpisodeDomain = mapper.map(from: dto)
        
        #expect(episodeDomainModel.id == dto.id)
        #expect(episodeDomainModel.airDate == dto.airDate)
        #expect(episodeDomainModel.characters == dto.characters)
        #expect(episodeDomainModel.episode == dto.episode)
        #expect(episodeDomainModel.name == dto.name)
    }
}
