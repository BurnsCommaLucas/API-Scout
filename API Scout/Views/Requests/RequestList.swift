//
//  RequestList.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

struct RequestList: View {
    @Binding var allRequests: [Request]
    @Binding var requestHasBeenRun: Bool
    @Binding var responseContents: ResponseData
    
    var body: some View {
        List($allRequests) { $request in
            NavigationLink {
                RequestDetailView(
                    request: $request,
                    requestHasBeenRun: $requestHasBeenRun,
                    responseContents: $responseContents
                )
            } label: {
                RequestRow(request: request)
            }
        }.navigationTitle("Requests")
            .frame(minWidth: 200)
    }
}

#Preview {
    RequestList(
        allRequests: .constant([Request(), Request()]),
        requestHasBeenRun: .constant(true),
        responseContents: .constant(ResponseData())
    )
}
