//
//  RequestDetailView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI

struct RequestDetailView: View {
    @Binding var requestHasBeenRun: Bool
    @Binding var responseContents: ResponseData
    @State private var editingRequestTitle: Bool = false
    @State private var selectedTab: Int = 1
    @EnvironmentObject var request: Request
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    if editingRequestTitle {
                        TextField("", text: $request.name)
                            .onSubmit {
                                editingRequestTitle.toggle()
                            }
                    } else {
                        Text(request.name == "" ? "New Request" : request.name)
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
                
                Picker("Method:", selection: $request.method) {
                    ForEach(HTTPMethod.allCases) { method in
                        Text(method.rawValue)
                            .foregroundColor(method.color)
                    }
                }
                
                HStack {
                    TextField("URL:", text: $request.url)
                    Button() {
                        RequestRunner(
                            selectedRequest: request,
                            requestHasBeenRun: $requestHasBeenRun,
                            responseContents: $responseContents
                        ).run()
                    } label: {
                        Label("Send", systemImage: "paperplane")
                            .labelStyle(.iconOnly)
                    }
                    .help("")
                    .keyboardShortcut(KeyboardShortcut(KeyEquivalent.return, modifiers: EventModifiers.command))
                }
            }
            TabView(selection: $selectedTab,
                    content:  {
                BodyEditorView(
                    selectedBodyType: $request.bodyType,
                    selectedBodyData: $request.bodyData
                )
                .tabItem { Text("Body") }.tag(1)
                // TODO: Auth
//                Text("Tab Content 2").tabItem { Text("Auth") }.tag(2)
                // TODO: Query param parsing/building
//                Text("Tab Content 3").tabItem { Text("Query") }.tag(3)
                HeaderEditor().tabItem { Text("Headers") }.tag(4)
            })
        }
        .padding()
        .frame(minWidth: 500)
    }
}


#Preview{
    RequestDetailView(
        requestHasBeenRun: .constant(true),
        responseContents: .constant(ResponseData(body: sampleBodyData, response: sampleResponse))
    )
    .environmentObject(GeneralSettings())
    .environmentObject(Request(id: "", name: "", method: .GET, url: "", bodyType: .JSON, bodyData: sampleJson, headers: []))
}
