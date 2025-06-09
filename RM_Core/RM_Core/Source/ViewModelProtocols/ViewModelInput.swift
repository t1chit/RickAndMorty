//
//  ViewModelInput.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 07.06.25.
//

import Foundation

public protocol ViewModelInput {
    associatedtype Intent
    
    @MainActor
    func send(_ intent: Intent)
}
