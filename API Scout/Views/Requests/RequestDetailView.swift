//
//  RequestDetailView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI

struct RequestDetailView: View {
    @Binding var request: Request
    @Binding var requestHasBeenRun: Bool
    @Binding var responseContents: ResponseData
    @State private var editingRequestTitle: Bool = false
    @State private var selectedTab: Int = 1
    
    var body: some View {
        VStack {
            HStack {
                if editingRequestTitle {
                    TextField("Request Name", text: $request.name)
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
            
            HStack {
                Picker("Method:", selection: $request.method) {
                    ForEach(HTTPMethod.allCases) { method in
                        Text(method.rawValue)
                            .foregroundColor(method.color)
                    }
                }
                
                TextField("URL", text: $request.url)
                Button()
                {
                    RequestRunner(
                        selectedRequest: $request,
                        requestHasBeenRun: $requestHasBeenRun,
                        responseContents: $responseContents
                    ).run()
                } label: {
                    Label("Send", systemImage: "paperplane")
                        .labelStyle(.iconOnly)
                }
                .keyboardShortcut(KeyboardShortcut(KeyEquivalent.return, modifiers: EventModifiers.command))
            }
            TabView(selection: $selectedTab,
                    content:  {
                BodyEditorView(
                    selectedBodyType: $request.bodyType,
                    selectedBodyData: $request.bodyData
                )
                .tabItem { Text("Body") }.tag(1)
                Text("Tab Content 2").tabItem { Text("Auth") }.tag(2)
                Text("Tab Content 3").tabItem { Text("Query") }.tag(3)
                HeaderEditor(request: $request).tabItem { Text("Headers") }.tag(4)
            })
        }
        .padding()
        .frame(minWidth: 500)
    }
}


#Preview{
    RequestDetailView(
        request: .constant(Request(bodyData: sampleJson)),
        requestHasBeenRun: .constant(true),
        responseContents: .constant(ResponseData(body: sampleBody, response: sampleResponse))
    )
}
