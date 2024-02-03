//
//  HTTPMethod.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import Foundation
import SwiftUI

enum HTTPMethod: String, Codable, CaseIterable, Identifiable{
    case
    GET = "GET",
    POST = "POST",
    PUT = "PUT",
    PATCH = "PATCH",
    DELETE = "DELETE",
    OPTIONS = "OPTIONS",
    HEAD = "HEAD"
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .GET:
            return Color.purple
        case .POST:
            return Color.green
        case .PUT:
            return Color.orange
        case .PATCH:
            return Color.yellow
        case .DELETE:
            return Color.red
        case .OPTIONS:
            return Color.blue
        case .HEAD:
            return Color.blue
        }
    }
}
