//
//  RequestRow.swift
//  API Scout
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI

struct RequestRow: View {
    var request: Request
    
    var body: some View {
        HStack {
            Text(request.method.rawValue)
                .foregroundColor(request.method.color)
            
            Text(request.name == "" ? "New Request" : request.name)
        }
    }
}

#Preview {
    Group {
        RequestRow(request: Request())
        RequestRow(request: Request(
            id: "", name: "Hit Endpoint", method: .POST, url: "", bodyType: .JSON, bodyData: "", headers: [], response: ResponseData()
        ))
        RequestRow(request: Request(
            id: "", name: "Hit Endpoint", method: .PUT, url: "", bodyType: .JSON, bodyData: "", headers: [], response: ResponseData()
        ))
    }
}
