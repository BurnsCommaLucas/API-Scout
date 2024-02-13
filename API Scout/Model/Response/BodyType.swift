//
//  HTTPMethod.swift
//  API Scout
//
//  Created by Lucas on 1/31/24.
//

import Foundation
import SwiftUI
import CodeEditor

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
    
    var headerValue: String? {
        switch self {
        case .PLAIN:
            return "text/plain"
        case .JSON:
            return "application/json"
        default:
            return nil
        }
    }
    
    var codeEditorLanguage: CodeEditor.Language {
        switch self {
        case .JSON:
            return .json
        default:
            return .markdown
        }
    }
    
    var id: Self { self }
}
