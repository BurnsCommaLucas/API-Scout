//
//  HTTPMethod.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import Foundation
import SwiftUI

enum BodyType: String, Codable, CaseIterable, Identifiable{
    case
    JSON,
    PLAIN,
    NONE
    
    var friendlyName: String {
        switch self {
        case .NONE:
            return "No Body"
        case .PLAIN:
            return "Plain"
        default:
            return self.rawValue
        }
    }
    
    var headerString: String? {
        switch self {
        case .PLAIN:
            return "text/plain"
        case .JSON:
            return "application/json"
        default:
            return nil
        }
    }
    var id: Self { self }
}
