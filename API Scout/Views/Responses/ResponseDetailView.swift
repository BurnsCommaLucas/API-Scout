//
//  ResponseViewer.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

struct ResponseDetailView: View {
    @Binding var request: Request?
    @Binding var requestHasBeenRun: Bool
    @Binding var responseData: ResponseData
    @State private var selectedTab: Int = 1
    
    var body: some View {
        if !requestHasBeenRun {
            Text("Run a Request")
        } else {
            VStack(alignment: .leading) {
                if let httpResponse = responseData.response as? HTTPURLResponse {
                    StatusCode(code: httpResponse.statusCode)
                }
                TabView(
                    selection: $selectedTab,
                    content:  {
                        if responseData.contentTypeIsRenderable {
                            ResponseRenderView(
                                request: $request,
                                responseData: $responseData
                            )
                            .tabItem { Text("Preview") }.tag(1)
                            .padding()
                        }
                        ResponseRawView(responseData: $responseData)
                            .tabItem { Text("Raw") }
                            .tag(2)
                        ResponseHeaders(responseData: $responseData).tabItem { Text("Headers") }.tag(3)
                        
                    }
                )
            }.frame(minWidth: 500)
                .padding()
        }
    }
}

#Preview {
    ResponseDetailView(
        request: .constant(requests[0]),
        requestHasBeenRun: .constant(true),
        responseData: .constant(
            ResponseData(
                body: sampleSvgData,
                response: sampleRenderableResponse
            )
        )
    )
}
