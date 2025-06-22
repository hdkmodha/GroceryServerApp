//
//  GroceryItem.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 15/06/25.
//

import Foundation
import Fluent
import Vapor

final class GroceryItem: Model, Content, @unchecked Sendable {
    
    static let schema: String = "grocery_items"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "price")
    var price: Double
    
    @Field(key: "quantity")
    var quantity: Int
    
    @Parent(key: "category_id")
    var groceryCategory: GroceryCategory
    
    required init() {
        
    }
    
    init(id: UUID? = nil, title: String, price: Double, quantity: Int, groceryCategoryId: UUID) {
        self.id = id
        self.title = title
        self.price = price
        self.quantity = quantity
        self.$groceryCategory.id = groceryCategoryId
    }
}
