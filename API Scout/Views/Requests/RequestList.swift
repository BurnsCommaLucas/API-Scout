//
//  RequestList.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import SwiftData

// This file is made weird by the fact that multiselect doesn't work with NavigationSplitView:
// https://stackoverflow.com/questions/72539222/swiftui-list-multiselect-with-navigationlink
struct RequestList: View {
    @Binding var selectedRequests: Set<Request>
    // FIXME: Is supposed to be @Bindable apparently
    @Binding var activeRequest: Request?
    
    @Environment(\.modelContext) var modelContext
    @Query var allRequests: [Request]
    
    var body: some View {
        VStack {
            List(allRequests, id: \.self, selection: $selectedRequests) { request in
                // TODO: Allow reordering
                // TODO: Folders/groups
                RequestRow(request: request)
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action: { duplicate(origin: request) }, label: {
                            Label("Duplicate", systemImage: "doc.on.doc")
                        })
                        Divider()
                        Button(action: removeSelected, label: {
                            Label("Delete", systemImage: "minus")
                        })
                    }))
            }
            .onChange(of: selectedRequests) { _, newValue in
                switch newValue.count {
                case 0:
                    activeRequest = nil
                case 1:
                    activeRequest = newValue.first!
                default:
                    () // Intentional no-op, leave the activeRequest unchanged
                }
            }
        }
        
        ControlGroup {
            Button(action: newRequest) {
                Label("Add Item", systemImage: "plus")
            }
            Button(action: removeSelected, label: {
                Label("Remove Items", systemImage: "minus")
            })
        }
        .padding()
    }
    
    // MARK: Request list modifier functions -
    private func newRequest() {
        let newRequest = Request()
        withAnimation {
            modelContext.insert(newRequest)
        }
        do {
            try modelContext.save()
        } catch {}
    }
    
    private func duplicate(origin: Request) {
        withAnimation {
            let duplicate = Request(from: origin)
            modelContext.insert(duplicate)
            // TODO: put duplicate item directly after origin item
            activeRequest = duplicate
            do {
                try modelContext.save()
            } catch {}
        }
    }
    
    private func removeSelected() {
        withAnimation {
            selectedRequests.forEach { selected in
                modelContext.delete(selected)
            }
            selectedRequests.removeAll()
            do {
                try modelContext.save()
            } catch {}
        }
    }
    
    private func removeOne(target: Request) {
        withAnimation {
            modelContext.delete(target)
            selectedRequests.remove(target)
            do {
                try modelContext.save()
            } catch {}
        }
    }
}

#Preview {
    @State var selectedRequests: Set<Request> = []
    @State var activeRequest: Request? = Request()
    return RequestList(selectedRequests: $selectedRequests, activeRequest: $activeRequest)
        .modelContainer(for: Request.self, inMemory: true)
}
