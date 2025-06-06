//
//  UserController.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 05/06/25.
//

import Foundation
import Fluent
import Vapor

class UserController: RouteCollection, @unchecked Sendable {
    
    func boot(routes: any RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.post("register", use: register)
    }
    
    func register(req: Request) async throws -> RegisterResponseDTO {
        
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "username already taken.")
        }
        
        user.password = try await req.password.async .hash(user.password)
        
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
}
