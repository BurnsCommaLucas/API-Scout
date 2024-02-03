//
//  Request.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import Foundation

struct Request: Hashable, Codable, Identifiable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    
    var id: UUID = UUID()
    var name: String = ""
    var method: HTTPMethod = HTTPMethod.GET
    var url: String = ""
    var bodyType: BodyType = BodyType.NONE
    var bodyData: String = ""
    
//    static func == (lhs: Request, rhs: Request) -> Bool {
//        lhs.id == rhs.id
//    }
}
