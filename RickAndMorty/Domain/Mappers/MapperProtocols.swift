//
//  MapperProtocols.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 06.06.25.
//

import Foundation

protocol MapperFromDTOToDomain {
    associatedtype DTO
    associatedtype Domain
    
    func map(from dto: DTO) -> Domain
}


protocol MapperFromDomainToDTO {
    associatedtype DTO
    associatedtype Domain
    
    func map(from dto: Domain) -> DTO
}
