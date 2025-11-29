//
//  UserController.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 05/06/25.
//

import Foundation
import Fluent
import Vapor
import GroceryAppSharedDTO

class UserController: RouteCollection, @unchecked Sendable {
    
    func boot(routes: any RoutesBuilder) throws {
        let api = routes.grouped("api")
        // Register
        api.post("register", use: register)
        // Login
        api.post("login", use: login)
    }
    
    
    func login(req: Request) async throws -> LoginResponseDTO {
        
        let user = try req.content.decode(User.self)
        
        guard let exitingUser = try await User.query(on: req.db).filter(\.$username == user.username).first() else {
            throw Abort(.badRequest)
        }
        
        let result = try await req.password.async.verify(user.password, created: exitingUser.password)
        
        guard result else { throw Abort(.unauthorized) }
        
        let authPayload = try AuthPayload(
            expiration: .init(value: .distantFuture),
            userId: exitingUser.requireID())
        
        
        return try await LoginResponseDTO(
            token: req.jwt.sign(authPayload),
            userId: exitingUser.requireID())
    }
    
    func register(req: Request) async throws -> RegisterResponseDTO {
        
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "username already taken.")
        }
        
        user.password = try await req.password.async.hash(user.password)
        
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
}
