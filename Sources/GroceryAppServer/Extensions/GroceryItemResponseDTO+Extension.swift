//
//  GroceryItemResponseDTO+Extension.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 15/06/25.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension GroceryItemResponseDTO: Content, @unchecked Sendable {
    
    init?(_ groceryItem: GroceryItem) {
        guard let id = groceryItem.id else {
            return nil
        }
        
        self.init(
            id: id,
            title:groceryItem.title,
            price: groceryItem.price,
            quantity: groceryItem.quantity
        )
    }
}
