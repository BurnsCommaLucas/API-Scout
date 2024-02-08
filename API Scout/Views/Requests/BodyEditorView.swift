//
//  BodyEditorView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI
import AppKit
import CodeEditor

struct BodyEditorView: View {
    
    @Binding var selectedBodyType: BodyType
    @Binding var selectedBodyData: String
    @State var textVisual: NSAttributedString = NSAttributedString()
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var generalSettings: GeneralSettings
    
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
                theme: generalSettings.currentThemeName(colorScheme: colorScheme),
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
            .environmentObject(GeneralSettings())
    }
}
