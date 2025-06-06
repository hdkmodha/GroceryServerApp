//
//  LoginResponseDTO.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 06/06/25.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content {
    let error: Bool
    let token: String?
    let userId: User
    var reason: String? = nil
}
