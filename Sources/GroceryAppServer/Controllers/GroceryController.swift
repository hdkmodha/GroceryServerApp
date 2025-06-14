//
//  GroceryController.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 10/06/25.
//

import Foundation
import GroceryAppSharedDTO
import Vapor
import Fluent

final class GroceryController: RouteCollection, @unchecked Sendable {
    
    func boot(routes: any RoutesBuilder) throws {
        let api = routes.grouped("api", "users", ":userId")
        
        //api/users/userId/createGroceryCategory
        api.post("grocery-categories", use: createGroceryCategory)
        //api/users/userId/getGroceryCategory
        api.get("grocery-categories", use: getGroceryCategories)
        
        //api/users/userId/getGroceryCategory/groceryCategoryId
        api.delete("grocery-categories", ":groceryCategoryId", use: deleteGroceryCategory)
    }
    
    func createGroceryCategory(req: Request) async throws -> GroceryCategoryResponseDTO {
        
        guard let userId =  req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let groceryRequestDTO = try req.content.decode(GroceryCategoryRequestDTO.self)
        let groceryCategory = GroceryCategory(
            title: groceryRequestDTO.title,
            colorCode: groceryRequestDTO.colorCode,
            userId: userId)
        try await groceryCategory.save(on: req.db)
        
        guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
            throw Abort(.internalServerError)
        }
        
        return groceryCategoryResponseDTO
    }
    
    func getGroceryCategories(req: Request) async throws -> [GroceryCategoryResponseDTO] {
        
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .all()
            .compactMap(GroceryCategoryResponseDTO.init)
    }
    
    func deleteGroceryCategory(req: Request) async throws -> GroceryCategoryResponseDTO {
        
        guard let userId = req.parameters.get("userId", as: UUID.self), let groceryId = req.parameters.get("groceryCategoryId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .filter(\.$id == groceryId)
            .first() else {
            throw Abort(.notFound)
        }
        
        try await groceryCategory.delete(on: req.db)
        
        guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
            throw Abort(.notFound)
        }
        
        return groceryCategoryResponseDTO
    }
}
