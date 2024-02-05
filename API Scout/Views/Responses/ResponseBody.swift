//
//  ResponseBody.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import CodeEditor

struct ResponseBody: View {
    @Binding var requestHasBeenRun: Bool
    @Binding var responseData: ResponseData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let decodedBody = responseData.decodedBody {
                    CodeEditor(
                        source: .constant(decodedBody),
                        language: .json,
                        // TODO customizable theme
                        flags: .defaultViewerFlags
                    )
                } else {
                    Text("No Body")
                }
            }
        }
    }
}

#Preview {
    ResponseBody(requestHasBeenRun: .constant(true), responseData: .constant(ResponseData(body: sampleBody, response: sampleResponse)))
}
