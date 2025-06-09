//
//  LocationDTO.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 08.06.25.
//



import Foundation

public struct LocationDTO: Codable {
    public let name: String
    public let url: String
    
    public init(
        name: String,
        url: String
    ) {
        self.name = name
        self.url = url
    }
}
