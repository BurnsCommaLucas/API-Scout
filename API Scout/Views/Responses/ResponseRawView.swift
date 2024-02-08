//
//  ResponseRawViewer.swift
//  API Scout
//
//  Created by Lucas on 2/6/24.
//

import SwiftUI
import CodeEditor

struct ResponseRawView: View {
    @Binding var responseData: ResponseData

    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var generalSettings: GeneralSettings
    
    var body: some View {
        if let decodedBody = responseData.decodedBody {
            CodeEditor(
                source: .constant(decodedBody),
                language: responseData.contentTypeLanguage,
                theme: generalSettings.currentTheme(currentScheme: colorScheme),
                flags: .defaultViewerFlags
            )
            .padding()
        } else {
            Text("No Body")
        }
    }
}

#Preview {
    ResponseRawView(responseData: .constant(ResponseData(body: sampleSvgData)))
        .environmentObject(GeneralSettings())
}
