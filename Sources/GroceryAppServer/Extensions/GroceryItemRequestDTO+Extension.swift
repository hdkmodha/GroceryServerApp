//
//  GroceryItemRequestDTO+Extension.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 15/06/25.
//

import GroceryAppSharedDTO
import Vapor

extension GroceryItemRequestDTO: Content, @unchecked Sendable {}
