//
//  BaseResponse.swift
//  GroceryAppServer
//
//  Created by Hardik Modha on 11/06/25.
//

import Foundation
import Vapor



struct BaseResponse<T: Content>: Content {
    let status: Int
    let message: String
    let data: T?
}

extension BaseResponse {
    static func success(data: T?, message: String = "Success", status: Int = 200) -> BaseResponse {
        return BaseResponse(status: status, message: message, data: data)
    }

    static func failure(message: String = "Something went wrong", status: Int = 400) -> BaseResponse<T> {
        return BaseResponse(status: status, message: message, data: nil)
    }
}
