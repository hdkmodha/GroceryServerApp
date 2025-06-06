//
//  RegisterResponseDTO.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 05/06/25.
//

import Foundation
import Fluent
import Vapor

struct RegisterResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
}
