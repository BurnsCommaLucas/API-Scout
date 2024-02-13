//
//  RequestDetailView.swift
//  API Scout
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI
import SwiftData

struct RequestDetailView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var editingRequestTitle: Bool = false
    @State private var selectedTab: Int = 1
    
    @Bindable var activeRequest: Request
    
    var body: some View {
        VStack {
            Form {
                // MARK: Request Title
                HStack {
                    if editingRequestTitle {
                        TextField("", text: $activeRequest.name)
                            .onSubmit {
                                editingRequestTitle.toggle()
                            }
                    } else {
                        Text(/*requestState.*/activeRequest.name == "" ? "New Request" : /*requestState.*/activeRequest.name)
                            .font(.title3)
                        Spacer()
                    }
                    
                    
                    Button{
                        editingRequestTitle.toggle()
                    } label: {
                        Label("Edit Request Name", systemImage: "pencil")
                            .labelStyle(.iconOnly)
                    }
                }
                
                // MARK: Request base info
                Picker("Method:", selection: $activeRequest.method) {
                    ForEach(HTTPMethod.allCases) { method in
                        Text(method.rawValue)
                            .foregroundColor(method.color)
                    }
                }
                
                // MARK: The go button
                HStack {
                    TextField("URL:", text: $activeRequest.url)
                    RunRequestButton(activeRequest: activeRequest)
                }
            }
            
            // MARK: Request detail info
            TabView(selection: $selectedTab,
                    content:  {
                BodyEditorView(
                    selectedBodyType: $activeRequest.bodyType,
                    selectedBodyData: $activeRequest.bodyData
                )
                .tabItem { Text("Body") }.tag(1)
                // TODO: Auth
                //                Text("Tab Content 2").tabItem { Text("Auth") }.tag(2)
                // TODO: Query param parsing/building
                //                Text("Tab Content 3").tabItem { Text("Query") }.tag(3)
                HeaderEditor(headerEntries: $activeRequest.headers).tabItem { Text("Headers") }.tag(4)
            })
        }.padding()
    }
}


#Preview{
    
    @State var activeRequest = Request()
    return RequestDetailView(activeRequest: activeRequest)
        .environmentObject(EditorSettings())
}
