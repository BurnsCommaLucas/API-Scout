//
//  ResponseBody.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import CodeEditor
import WebKit

// FIXME: Invalidate/re-render when other renderable request is selected
struct ResponseRenderView: View {
    var request: Request
    var responseData: ResponseData
    
    var body: some View {
        if let body = responseData.decodedBody {
            WebView(renderableContent: body, baseUrl: request.baseUrl)
        }
    }
}

#Preview {
    ResponseRenderView(
        request: Request(
            id: "", name: "", method: .GET, url: "https://img.shields.io", bodyType: .PLAIN, bodyData: "", headers: [], response: ResponseData()
        ),
        responseData: ResponseData(body: sampleHtmlData, response: sampleRenderableResponse)
    )
}
