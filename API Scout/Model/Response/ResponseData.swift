//
//  ResponseData.swift
//  API Scout
//
//  Created by Lucas on 2/3/24.
//

import Foundation
import CodeEditor
import SwiftData

//@Model
//final class ResponseData {
struct ResponseData {
    var body: Data? = nil
    var response: URLResponse? = nil
    var error: Error? = nil
    var duration: ContinuousClock.Instant.Duration? = nil
    
    var decodedBody: String? {
        return if body != nil {
            // TODO: dynamic decoding
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
    
    private var contentTypeHeaderValue: String? {
        let contentTypeHeader = self.headers?.first(where: { (key: AnyHashable, _: Any) in
            "\(key)" == "Content-Type"
        }) as? (String, String?)
        
        return contentTypeHeader?.1
    }
    
    var estimatedContentType: ContentType {
        switch contentTypeHeaderValue {
        case nil:
                .PLAIN
        case let s where s!.matchFirst(/text\/html/):
                .HTML
        case let s where s!.matchFirst(/image\/svg/):
                .SVG
        default:
                .PLAIN
        }
    }
    
    var contentTypeIsRenderable: Bool {
        switch estimatedContentType {
        case .SVG:
            true
        case .HTML:
            true
        default:
            false
        }
    }
    
    var contentTypeLanguage: CodeEditor.Language {
        switch estimatedContentType {
        case .PLAIN:
            // There's no plaintext option and feeding the editor nil breaks it
                .markdown
        case .JSON:
                .json
        case .SVG:
            // I mean, probably, but also I bet this causes problems
                .xml
        case .HTML:
            // https://github.com/highlightjs/highlight.js/issues/3594 🤷‍♂️
                .xml
        case .XML:
                .xml
        }
    }
    
    enum ContentType {
        case PLAIN
        case JSON
        case SVG
        case HTML
        case XML
    }
}
