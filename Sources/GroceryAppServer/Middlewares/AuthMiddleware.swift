//
//  AuthMiddleware.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 03/07/25.
//

import Foundation
import Vapor

struct AuthMiddleware: AsyncRequestAuthenticator {
    func authenticate(request: Request) async throws {
        try await request.jwt.verify(as: AuthPayload.self)
    }
}
