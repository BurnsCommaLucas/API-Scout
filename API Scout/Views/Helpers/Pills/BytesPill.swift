//
//  BytesPill.swift
//  API Scout
//
//  Created by Lucas on 2/12/24.
//

import SwiftUI

struct BytesPill: View {
    var data: Data
    
    init(_ data: Data) {
        self.data = data
    }
    
    var body: some View {
        let byteString = ByteCountFormatter.string(
            fromByteCount: Int64(data.count),
            countStyle: .file
        )
        
        Pill(byteString)
    }
}

#Preview {
    Group {
        BytesPill("".data(using: .utf8)!)
            .padding()
        BytesPill("hehe some words here".data(using: .utf8)!)
            .padding()
        BytesPill(sampleHtml.data(using: .utf8)!)
            .padding()
    }
}
