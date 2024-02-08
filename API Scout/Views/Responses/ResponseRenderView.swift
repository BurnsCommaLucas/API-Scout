//
//  ResponseBody.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import CodeEditor
import WebKit

// FIXME: Invalidate/re-render when request is re-run
struct ResponseRenderView: View {
    var request: Request?
    var responseData: ResponseData
    
    var body: some View {
        if let body = responseData.decodedBody {
            WebView(renderableContent: body, baseUrl: request?.baseUrl)
        }
    }
}

#Preview {
    ResponseRenderView(
        request: Request(
            id: "", name: "", method: .GET, url: "https://img.shields.io", bodyType: .PLAIN, bodyData: "", headers: []
        ),
        responseData: ResponseData(body: sampleHtmlData, response: sampleResponse)
    )
}
