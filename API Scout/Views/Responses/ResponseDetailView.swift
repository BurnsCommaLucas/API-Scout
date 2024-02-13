//
//  ResponseDetailView.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

struct ResponseDetailView: View {
    @ObservedObject var activeRequest: Request
    
    @State private var selectedTab: Int = 1
    
    var body: some View {
        // TODO: Check error states as well
        switch activeRequest.state {
        case .NOT_STARTED:
            Text("Run a Request")
        case .PREPARING, .STARTED:
            ProgressView()
        case .FINISHED:
            if let responseData = activeRequest.response {
                VStack(alignment: .leading) {
                    HStack {
                        // There's no way this is the most idiomatic way to do this, find a better pattern
                        if let httpResponse = responseData.response as? HTTPURLResponse {
                            StatusCodePill(code: httpResponse.statusCode).padding(.trailing, 20)
                        }
                        if let duration = responseData.duration {
                            DurationPill(duration).padding(.trailing, 20)
                        }
                        if let data = responseData.body {
                            BytesPill(data).padding(.trailing, 20)
                        }
                    }
                    .padding()
                    TabView(
                        selection: $selectedTab,
                        content:  {
                            if responseData.contentTypeIsRenderable {
                                ResponseRenderView(
                                    request: activeRequest,
                                    responseData: responseData
                                )
                                .tabItem { Text("Preview") }.tag(1)
                                .padding()
                            }
                            ResponseRawView(responseData: responseData)
                                .tabItem { Text("Raw") }
                                .tag(2)
                            ResponseHeaders(responseData: responseData).tabItem { Text("Headers") }.tag(3)
                            
                        }
                    )
                }
                .padding()
            }
            else {
                Text("error view I think?")
            }
        }
    }
}

#Preview {
    ResponseDetailView(activeRequest: Request(state: .FINISHED, response: ResponseData(body: sampleBodyData, response: sampleResponse, duration: Duration.milliseconds(0.2))))
    .environmentObject(EditorSettings())
}
