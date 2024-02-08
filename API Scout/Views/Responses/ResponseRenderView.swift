//
//  ResponseBody.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import CodeEditor
import WebKit

struct ResponseRenderView: View {
    @Binding var request: Request?
    @Binding var responseData: ResponseData
    
    var body: some View {
        if let body = responseData.decodedBody {
            WebView(renderableContent: body, baseUrl: request?.baseUrl)
        }
    }
}

#Preview {
    ResponseRenderView(
        request: .constant(Request(url: "https://img.shields.io")),
        responseData: .constant(ResponseData(body: sampleHtmlData, response: sampleResponse))
    )
}
