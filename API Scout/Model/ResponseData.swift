//
//  ResponseData.swift
//  API Scout
//
//  Created by Lucas on 2/3/24.
//

import Foundation

struct ResponseData {
    var body: Data?
    var response: URLResponse?
    var error: Error?
    
    var decodedBody: String? {
        return if body != nil {
            // TODO dynamic decoding
            String(decoding: body!, as: UTF8.self)
        } else {
            nil
        }
    }
    
    var headers: [AnyHashable : Any]? {
        return if let httpResponse = response as? HTTPURLResponse  {
            httpResponse.allHeaderFields
        }
        else {
            nil
        }
    }
    
    var statusCode: Int? {
        return if let httpResponse = response as? HTTPURLResponse {
            httpResponse.statusCode
        } else {
            nil
        }
    }
}
