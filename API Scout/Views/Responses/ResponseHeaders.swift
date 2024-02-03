//
//  ResponseHeaders.swift
//  API Scout
//
//  Created by Lucas on 2/3/24.
//

import SwiftUI

struct ResponseHeaders: View {
    @Binding var responseData: ResponseData
    
    var body: some View {
        
        if let headers: Dictionary<AnyHashable, Any?> = responseData.headers {
            // Remap the headers to something usable by the Table
            let headerArray = headers.map { (key: AnyHashable, value: Any?) in
                HeaderTableEntry(name: "\(key)", value: "\(value ?? "")")
            }
            
//            let clipboard = NSPasteboard.general
            
            Table(headerArray) {
                TableColumn("Name", value: \.name)
                TableColumn("Value", value: \.value)
//                TableColumn("") { e in
//                    Button {
//                        clipboard.setString("\(e.name): \(e.value)", forType: .string)
//                    } label: {
//                        Label("Copy", systemImage: "doc.on.doc").labelStyle(.iconOnly)
//                    }
//                }
            }
            .selectionDisabled(false)
            .monospaced()
            .padding()
        } else {
            Text("No Headers")
        }

    }
}

private struct HeaderTableEntry: Identifiable {
    var id: UUID = UUID()
    var name: String
    var value: String
}

#Preview {
    ResponseHeaders(responseData: .constant(ResponseData()))
}
