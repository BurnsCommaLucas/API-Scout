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
    
    var body: some View {
        VStack{
            Picker("Body Type:", selection: $selectedBodyType) {
                ForEach(BodyType.allCases) { bodyType in
                    Text(bodyType.friendlyName)
                }
            }
            CodeEditor(
                source: $selectedBodyData,
                language: .json,
                // TODO customizable theme
                flags: .defaultEditorFlags
            )
        }.padding()
    }
}

#Preview {
    BodyEditorView(selectedBodyType: .constant(BodyType.JSON), selectedBodyData: .constant(sampleJson))
}
