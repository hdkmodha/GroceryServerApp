//
//  CustomErrorMiddleware.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 11/06/25.
//

import Foundation
import Vapor

struct CustomErrorMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        do {
            return try await next.respond(to: request)
        } catch {
            let status: HTTPResponseStatus
            let message: String

            if let abort = error as? (any AbortError) {
                status = abort.status
                message = abort.reason
            } else {
                status = .internalServerError
                message = "Internal Server Error"
            }

            let errorResponse = BaseResponse<String>.failure( message: message, status: Int(status.code))
            let response = Response(status: status)
            try response.content.encode(errorResponse)
            return response
        }
    }
}
