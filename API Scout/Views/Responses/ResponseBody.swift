//
//  ResponseBody.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

struct ResponseBody: View {
    @Binding var requestHasBeenRun: Bool
    @Binding var responseData: ResponseData
    
    var body: some View {
        if !requestHasBeenRun {
            Text("Run a Request")
        }
        // TODO copy-all button
        // TODO syntax highlighting for JSON? (and others probably)
        
        else if responseData.decodedBody == nil {
            Text("No Body")
        }
        
        else {
            TextEditor(text: .constant(responseData.decodedBody!))
                .font(.custom("AndaleMono", size: 12))
                .padding()
        }
    }
}

#Preview {
    ResponseBody(requestHasBeenRun: .constant(true), responseData: .constant(ResponseData()))
}
