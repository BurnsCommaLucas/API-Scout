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
    
    var body: some View {
        TabView(
            selection: .constant(1),
            content:  {
                ResponseBody(requestHasBeenRun: $requestHasBeenRun, responseData: $responseData).tabItem { Text("Body") }.tag(1)
                Text("Tab Content 2").tabItem { Text("Headers") }.tag(2)
            }
        ).frame(minWidth: 500)
    }
}

#Preview {
    ResponseDetailView(requestHasBeenRun: .constant(true), responseData: .constant(ResponseData()))
}
