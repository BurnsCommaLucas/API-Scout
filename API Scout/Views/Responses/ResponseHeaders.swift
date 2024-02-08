//
//  ResponseHeaders.swift
//  API Scout
//
//  Created by Lucas on 2/3/24.
//

import SwiftUI

struct ResponseHeaders: View {
    @Binding var responseData: ResponseData
    
    @State private var selectedRows = Set<UUID>()
    
    var body: some View {
        
        if let headers: Dictionary<AnyHashable, Any?> = responseData.headers {
            // Remap the headers to something usable by the Table
            let headerArray = headers.map { (key: AnyHashable, value: Any?) in
                HeaderEntry(name: "\(key)", value: "\(value ?? "")")
            }.sorted { a, b in
                a.id < b.id
            }
            
            Table(headerArray, selection: $selectedRows) {
                TableColumn("Name", value: \.name)
                TableColumn("Value", value: \.value)
            }
            .textSelection(.enabled)
            .font(monoFont)
            .padding()
        } else {
            Text("No Headers")
        }
    }
}

#Preview {
    ResponseHeaders(responseData: .constant(ResponseData(body: sampleBodyData, response: sampleResponse)))
}
