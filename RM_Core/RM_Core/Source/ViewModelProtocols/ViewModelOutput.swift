//
//  ViewModelOutput.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 07.06.25.
//


import Foundation

public protocol ViewModelOutput {
    associatedtype State
    
    var state: State { get }
}
