//
//  ResponseViewer.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

struct ResponseDetailView: View {
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
                        ResponseBody(requestHasBeenRun: $requestHasBeenRun, responseData: $responseData)
                            .tabItem { Text("Body") }.tag(1)
                        ResponseHeaders(responseData: $responseData).tabItem { Text("Headers") }.tag(2)
                    }
                )
            }.frame(minWidth: 500)
        }
    }
}

#Preview {
    ResponseDetailView(requestHasBeenRun: .constant(true), responseData: .constant(ResponseData(body: sampleBody, response: sampleResponse)))
}
