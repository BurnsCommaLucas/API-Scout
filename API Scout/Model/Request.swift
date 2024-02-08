//
//  Request.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import Foundation
import SwiftData

@Model
final class Request: ObservableObject {
    // MARK: Params -
    var id: String = UUID().uuidString
    var name: String = ""
    var method: HTTPMethod = HTTPMethod.GET
    var url: String = ""
    var bodyType: BodyType = BodyType.NONE
    var bodyData: String = ""
    var headers: [HeaderEntry] = [HeaderEntry()]
    // TODO: auth
    
    
    // MARK: Constructors -
    init(id: String, name: String, method: HTTPMethod, url: String, bodyType: BodyType, bodyData: String, headers: [HeaderEntry]) {
        self.id = id
        self.name = name
        self.method = method
        self.url = url
        self.bodyType = bodyType
        self.bodyData = bodyData
        self.headers = headers
    }
    
    /// Create a new `Request` identical to the given request but with a different `id`
    init(from other: Request) {
        self.name = other.name
        self.method = other.method
        self.url = other.url
        self.bodyType = other.bodyType
        self.bodyData = other.bodyData
        self.headers = other.headers
    }
    
    init() {}
    
    /// Extract base url (domain + method if available) from full url string
    var baseUrl: String? {
        url.firstMatch(of: /^.+?[^\/:](?=[?\/]|$)/)?.base
    }
}
