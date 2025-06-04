//
//  ViewModelOutput.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 03.06.25.
//

import Foundation

protocol ViewModelOutput {
    associatedtype State
    
    var state: State { get }
}
