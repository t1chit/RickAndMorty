//
//  ViewModelInput.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 03.06.25.
//

import Foundation

protocol ViewModelInput {
    associatedtype Intent
    
    @MainActor
    func send(_ intent: Intent)
}
