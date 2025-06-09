//
//  Injection.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Swinject
import RM_Network_Service
import RM_Character_List
import RM_Details
import RM_Search
import RM_Episodes

final class DIContainer {
    static let shared = DIContainer()
    
    private let assembler: Assembler

    var container: Resolver {
        assembler.resolver
    }
    
    private init() {
        assembler = Assembler([
            RMCharacterListAssembly(),
            RMDetailsAssembly(),
            EpisodesAssambly(),
            RMSearchAssembly()
        ])
    }
}
