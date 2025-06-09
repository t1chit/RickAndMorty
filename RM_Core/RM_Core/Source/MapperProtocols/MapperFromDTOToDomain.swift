//
//  MapperFromDTOToDomain.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation

public protocol MapperFromDTOToDomain {
    associatedtype DTO
    associatedtype Domain
    
    func map(from dto: DTO) -> Domain
}


public protocol MapperFromDomainToDTO {
    associatedtype DTO
    associatedtype Domain
    
    func map(from dto: Domain) -> DTO
}
