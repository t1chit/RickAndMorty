//
//  HTTPMethod.swift
//  RM_Network_Service
//
//  Created by Temur Chitashvili on 06.06.25.
//

import Foundation

// MARK: - HTTP Method Enum
public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - Endpoint Protocol
public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

public extension Endpoint {
    var urlRequest: URLRequest? {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
}

// MARK: - Endpoint Manager
public enum EndPointsManager: Endpoint {
    case getCharacters
    case getCharacterDetials(id: Int)
    case searchCharacter(name: String)
    case getCharactersWithPagination(page: Int)
}

public extension EndPointsManager {
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com")!
    }
    
    var path: String {
        switch self {
        case .getCharacters, .searchCharacter(_), .getCharactersWithPagination(_):
            return "/api/character"
        case .getCharacterDetials(let id):
            return "/api/character/\(id)"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters, .getCharacterDetials(_), .searchCharacter(_), .getCharactersWithPagination(_):
            return .GET
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCharacters, .getCharacterDetials(_), .searchCharacter(_), .getCharactersWithPagination(_):
            return ["Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCharacters, .getCharacterDetials(_):
            return nil
        case .searchCharacter(let name):
            return [URLQueryItem(name: "name", value: name)]
        case .getCharactersWithPagination(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        }
    }
    
    var body: Data? {
        switch self {
        case .getCharacters, .getCharacterDetials(_), .searchCharacter(_), .getCharactersWithPagination(_):
            return nil
        }
    }
}
