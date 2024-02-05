//
//  Extensions.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

extension String {
   func widthOfString(usingFont font: Font) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

let monoFont = Font.custom("Menlo", size: 12)

let sampleJson = "{\n" +
"    \"id\": \"1\",\n" +
"    \"type\": \"icecream\",\n" +
"    \"name\": \"Vanilla Cone\",\n" +
"    \"image\": {\n" +
"        \"url\": \"img/01.png\",\n" +
"        \"width\": 200,\n" +
"        \"height\": 200\n" +
"        \"enabled\": false\n" +
"    },\n" +
"    \"thumbnail\": {\n" +
"        \"url\": \"images/thumbnails/01.png\",\n" +
"        \"width\": 32,\n" +
"        \"height\": 32\n" +
"    }\n" +
"}"


let sampleBody = sampleJson.data(using: .utf8)
let sampleResponse = HTTPURLResponse(
    url: URL(string: "http://localhost:8080")!,
    statusCode: 200,
    httpVersion: "1.2",
    headerFields: ["Header A": "Value A", "Header B": "Value B"]
)
