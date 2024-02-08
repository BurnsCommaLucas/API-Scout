//
//  Request.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import Foundation

struct Request: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var method: HTTPMethod = HTTPMethod.GET
    var url: String = ""
    var bodyType: BodyType = BodyType.NONE
    var bodyData: String = ""
    var headers: [HeaderEntry] = [HeaderEntry()]
    // TODO auth
    
    /// Extract base url (domain + method if available) from full url string
    var baseUrl: String? {
        url.firstMatch(of: /^.+?[^\/:](?=[?\/]|$)/)?.base
    }
}
