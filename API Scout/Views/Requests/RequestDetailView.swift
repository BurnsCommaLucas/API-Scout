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
            }
            TabView(selection: .constant(1),
                    content:  {
                BodyEditorView(
                    selectedBodyType: $request.bodyType,
                    selectedBodyData: $request.bodyData
                )
                .tabItem { Text("Body") }.tag(1)
                Text("Tab Content 2").tabItem { Text("Auth") }.tag(2)
                Text("Tab Content 3").tabItem { Text("Query") }.tag(2)
                Text("Tab Content 4").tabItem { Text("Headers") }.tag(2)
            })
        }
        .padding()
        .frame(minWidth: 500)
    }
}


#Preview{
    RequestDetailView(
        request: .constant(Request()),
        requestHasBeenRun: .constant(false),
        responseContents: .constant(ResponseData())
    )
}
