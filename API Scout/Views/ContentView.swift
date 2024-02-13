//
//  MainView.swift
//  API Scout
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedRequests: Set<Request> = []
    @State private var activeRequest: Request? = nil
    
    var body: some View {
        NavigationSplitView {
            RequestList(selectedRequests: $selectedRequests, activeRequest: $activeRequest)
                .navigationSplitViewColumnWidth(min: 180, ideal: 220)
        } content: {
            if activeRequest != nil {
                RequestDetailView(activeRequest: activeRequest!)
                    .navigationSplitViewColumnWidth(min: 450, ideal: 550)
            }
            else {
                Text("Select a Request")
                    .navigationSplitViewColumnWidth(min: 450, ideal: 550)
            }
        } detail: {
            if activeRequest != nil {
                ResponseDetailView(activeRequest: activeRequest!)
                    .navigationSplitViewColumnWidth(min: 450, ideal: 550)
            }
            else {
                Text("Select a Request")
                    .navigationSplitViewColumnWidth(min: 450, ideal: 550)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Request.self, inMemory: true)
        .environmentObject(EditorSettings())
}
