//
//  RequestRow.swift
//  apiBoss
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
    RequestRow(request: Request())
}
