//
//  AuthPayload.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 06/06/25.
//

import Foundation
import JWT
import Vapor

struct AuthPayload: JWTPayload {
    
    typealias Payload = AuthPayload
    
    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case userId = "uid"
    }
    
    var expiration: ExpirationClaim
    var userId: UUID
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expiration.verifyNotExpired()
    }
}
