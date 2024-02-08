//
//  MainView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    // FIXME: really should just be an environmentObject keeping track of 90% of this state
    @State private var allRequests: [Request] = requests
    @State private var selectedRequest: Request? = nil
    @State private var requestHasBeenRun: Bool = false
    @State private var responseContents: ResponseData = ResponseData()
    
    var body: some View {
        NavigationSplitView{
            RequestList(
                allRequests: $allRequests, 
                requestHasBeenRun: $requestHasBeenRun,
                responseContents: $responseContents
            )
                .frame(minWidth: 200)
        } content: {
            Text("Select a Request")
                .frame(minWidth: 500)
        } detail: {
            ResponseDetailView(
                request: $selectedRequest,
                requestHasBeenRun: $requestHasBeenRun,
                responseData: $responseContents
            ).frame(minWidth: 500)
        }
    }
}

#Preview {
    ContentView()
}
