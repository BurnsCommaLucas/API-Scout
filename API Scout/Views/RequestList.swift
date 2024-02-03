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
        //🤔
//        Table($allRequests,
//              //            of: Request,
//              columns: {
//            TableColumn("") { $r in
//                NavigationLink {
//                    RequestDetailView(
//                        request: $r,
//                        requestHasBeenRun: $requestHasBeenRun,
//                        responseData: $responseData
//                    )
//                } label: {
//                    Text(r.method.rawValue).foregroundStyle(r.method.color)
//                }
//            }
//            TableColumn("") { $r in
//                NavigationLink {
//                    RequestDetailView(
//                        request: $r,
//                        requestHasBeenRun: $requestHasBeenRun,
//                        responseData: $responseData
//                    )
//                } label: {
//                    Text(r.name == "" ? "New Request" : r.name)
//                }
//            }
//    }, rows: {
//        ForEach($allRequests) { $r in
//            TableRow(r)
//            NavigationLink {
//                RequestDetailView(
//                    request: $r,
//                    requestHasBeenRun: $requestHasBeenRun,
//                    responseData: $responseData
//                )
//            } label: {
//                //                        RequestRow(request: r)
//            }
//        }
//        }
//    )
//        .alternatingRowBackgrounds(.disabled)
//        .tableColumnHeaders(.hidden)
    }
}

#Preview {
    RequestList(
        allRequests: .constant([Request(), Request()]),
        requestHasBeenRun: .constant(true),
        responseContents: .constant(ResponseData())
    )
}
