//
//  Request.swift
//  API Scout
//
//  Created by Lucas on 1/31/24.
//

import Foundation
import SwiftData

@Model
final class Request: ObservableObject {
    // MARK: Params -
    var id: String
    var name: String
    var method: HTTPMethod
    var url: String
    var bodyType: BodyType
    var bodyData: String
    var headers: [HeaderEntry]
    @Transient
    @Published
    var state: RunState = RunState.NOT_STARTED
    @Transient
    @Published
    var response: ResponseData?
    // TODO: auth
    
    /// Extract base url (domain + method if available) from full url string
    var baseUrl: String? {
        url.firstMatch(of: /^.+?[^\/:](?=[?\/]|$)/)?.base
    }
    
    // MARK: Constructors -
    init(
        id: String = UUID().uuidString,
        name: String = "",
        method: HTTPMethod = .GET,
        url: String = "",
        bodyType: BodyType = .NONE,
        bodyData: String = "",
        headers: [HeaderEntry] = [HeaderEntry()],
        state: RunState = RunState.NOT_STARTED,
        response: ResponseData? = nil
    ) {
        self.id = id
        self.name = name
        self.method = method
        self.url = url
        self.bodyType = bodyType
        self.bodyData = bodyData
        self.headers = headers
        self.state = state
        self.response = response
    }
    
    /// Create a new `Request` identical to the given request but with a different `id`
    init(from other: Request) {
        self.id = UUID().uuidString
        self.name = other.name
        self.method = other.method
        self.url = other.url
        self.bodyType = other.bodyType
        self.bodyData = other.bodyData
        self.headers = other.headers
        self.state = other.state
        self.response = other.response
    }
}
