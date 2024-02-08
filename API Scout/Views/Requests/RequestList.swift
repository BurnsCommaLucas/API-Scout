//
//  RequestList.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import SwiftData

struct RequestList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allRequests: [Request]
    @Binding var requestHasBeenRun: Bool
    @Binding var responseContents: ResponseData
    
    var body: some View {
        List{
            ForEach(allRequests) { request in
                NavigationLink {
                    RequestDetailView(
                        requestHasBeenRun: $requestHasBeenRun,
                        responseContents: $responseContents
                    ).environmentObject(request)
                } label: {
                    RequestRow(request: request)
                }
            }.onDelete(perform: deleteItems)
        }
        .navigationTitle("Requests")
        .toolbar {
            ToolbarItem {
                Button("Delete", systemImage: "minus", action: {
                    
                })

            }
        }
    }
    
    // Pretty weird having this function not be next to addItems in `ContentView` tbh
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(allRequests[index])
            }
        }
    }
}

#Preview {
    RequestList(
        requestHasBeenRun: .constant(true),
        responseContents: .constant(ResponseData())
    ).modelContainer(for: Request.self, inMemory: true)
}
