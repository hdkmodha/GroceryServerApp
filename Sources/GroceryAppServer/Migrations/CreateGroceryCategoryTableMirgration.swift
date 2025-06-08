//
//  CreateGroceryCategoryTableMirgration.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 08/06/25.
//

import Foundation
import Fluent

struct CreateGroceryCategoryTableMirgration: AsyncMigration {
    
    private let tableName = "grocery_categories"
    
    func prepare(on database: any Database) async throws {
        try await database.schema(tableName)
            .id()
            .field("title", .string, .required)
            .field("color_code", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
            
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(tableName).delete()
    }
}
