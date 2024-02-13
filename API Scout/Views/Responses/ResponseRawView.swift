//
//  ResponseRawViewer.swift
//  API Scout
//
//  Created by Lucas on 2/6/24.
//

import SwiftUI
import CodeEditor

struct ResponseRawView: View {
    var responseData: ResponseData

    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var editorSettings: EditorSettings
    
    var body: some View {
        if let decodedBody = responseData.decodedBody {
            CodeEditor(
                source: .constant(decodedBody),
                language: responseData.contentTypeLanguage,
                theme: editorSettings.currentThemeName(colorScheme: colorScheme),
                flags: .defaultViewerFlags
            )
            .padding()
        } else {
            Text("No Body")
        }
    }
}

#Preview {
    ResponseRawView(responseData: ResponseData(body: sampleSvgData))
        .environmentObject(EditorSettings())
}
