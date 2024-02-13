//
//  BodyEditorView.swift
//  API Scout
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI
import AppKit
import CodeEditor

struct BodyEditorView: View {
    @Binding var selectedBodyType: BodyType
    @Binding var selectedBodyData: String
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var editorSettings: EditorSettings
    
    var body: some View {
        VStack{
            Form {
                Picker("Body Type:", selection: $selectedBodyType) {
                    ForEach(BodyType.allCases) { bodyType in
                        Text(bodyType.friendlyName)
                    }
                }
            }
            CodeEditor(
                source: $selectedBodyData,
                language: selectedBodyType.codeEditorLanguage,
                theme: editorSettings.currentThemeName(colorScheme: colorScheme),
                flags: .defaultEditorFlags
            )
            .disabled(selectedBodyType == .NONE)
            .opacity(selectedBodyType == .NONE ? 0.5 : 1.0)
        }.padding()
    }
}

struct BodyEditorView_Previews : PreviewProvider {
    @State static var bodyType = BodyType.JSON
    static var previews: some View {
        BodyEditorView(selectedBodyType: $bodyType, selectedBodyData: .constant(sampleJson))
            .environmentObject(EditorSettings())
    }
}
