//
//  MainView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allRequests: [Request]
    
    // FIXME: really should just be an environmentObject keeping track of 90% of this state
    @State var selectedRequestIds: Set<String> = []
    @State private var requestHasBeenRun: Bool = false
    @State private var responseContents: ResponseData = ResponseData()
    
    var body: some View {
        NavigationSplitView{
            VStack {
                List(selection: $selectedRequestIds){
                    // TODO: Rework the navigation to allow multi-selection
                    // https://stackoverflow.com/questions/72539222/swiftui-list-multiselect-with-navigationlink
                    // TODO: Allow reordering
                    // TODO: Folders/groups
                    
                    ForEach(allRequests) { request in
                        NavigationLink {
                            RequestDetailView(
                                requestHasBeenRun: $requestHasBeenRun,
                                responseContents: $responseContents
                            ).environmentObject(request)
                        } label: {
                            RequestRow(request: request)
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: { duplicate(id: request.id) }, label: {
                                Label("Duplicate", systemImage: "doc.on.doc")
                            })
                            Divider()
                            Button(action: {removeOne(id: request.id)}, label: {
                                Label("Delete", systemImage: "minus")
                            })
                        }))
                    }
                }
            }
            
            Spacer()
            
            ControlGroup {
                Button(action: newRequest) {
                    Label("Add Item", systemImage: "plus")
                }
                Button(action: removeSelected, label: {
                    Label("Remove Items", systemImage: "minus")
                })
            }.padding()
            .navigationTitle("Requests")
            .navigationSplitViewColumnWidth(min: 180, ideal: 220)
        } content: {
            Text("Select a Request")
                .navigationSplitViewColumnWidth(min: 450, ideal: 550)
        } detail: {
            ResponseDetailView(
                requestHasBeenRun: $requestHasBeenRun,
                responseData: responseContents
            )
            .navigationSplitViewColumnWidth(min: 450, ideal: 550)
        }
    }
    
    // MARK: Request list modifier functions -
    private func newRequest() {
        withAnimation {
            let newRequest = Request()
            modelContext.insert(newRequest)
        }
    }
    
    private func duplicate(id: String) {
        withAnimation {
            let descriptor = FetchDescriptor<Request>(
                predicate: #Predicate { $0.id == id }
            )
            do {
                let origin = try modelContext.fetch(descriptor).first!
                let duplicate = Request(from: origin)
                modelContext.insert(duplicate)
                // TODO: put duplicate item directly after origin item
            } catch {}
        }
    }
    
    private func removeSelected() {
        withAnimation {
            for r in selectedRequestIds {
                do {
                    try modelContext.delete(model: Request.self, where: #Predicate { req in
                        req.id == r
                    })
                } catch {}
            }
        }
    }
    
    private func removeOne(id: String) {
        withAnimation {
            do {
                try modelContext.delete(model: Request.self, where: #Predicate { req in
                    req.id == id
                })
            } catch {}
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Request.self, inMemory: true)
}
