//
//  MainView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var allRequests: [Request] = requests
    @State private var requestHasBeenRun: Bool = false
    @State private var responseContents: ResponseData = ResponseData()
    
    var body: some View {
        NavigationSplitView{
            RequestList(allRequests: $allRequests, requestHasBeenRun: $requestHasBeenRun, responseContents: $responseContents)
                .frame(minWidth: 200)
        } content: {
            Text("Select a Request")
                .frame(minWidth: 500)
        } detail: {
            ResponseDetailView(
                requestHasBeenRun: $requestHasBeenRun,
                responseData: $responseContents
            ).padding()
        }
    }
}

#Preview {
    ContentView()
}
