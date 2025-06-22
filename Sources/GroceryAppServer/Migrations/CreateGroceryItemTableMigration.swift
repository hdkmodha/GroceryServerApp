//
//  CreateGroceryItemTableMigration.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 15/06/25.
//

import Foundation
import Fluent

struct CreateGroceryItemTableMigration: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("grocery_items")
            .id()
            .field("title", .string, .required)
            .field("price", .double, .required)
            .field("quantity", .int, .required)
            .field("category_id", .uuid, .required, .references("grocery_categories", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("grocery_items").delete()
    }
}
