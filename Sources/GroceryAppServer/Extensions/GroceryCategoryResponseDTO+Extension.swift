//
//  GroceryCategoryResponseDTO+Extension.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 10/06/25.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension GroceryCategoryResponseDTO: Content, @unchecked Sendable {
    
    init?(_ groceryCategory: GroceryCategory) {
        guard let id = groceryCategory.id else { return nil }
        
        self.init(id: id, title: groceryCategory.title, colorCode: groceryCategory.colorCode)
    }
}
