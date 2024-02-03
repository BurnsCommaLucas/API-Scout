//
//  BodyEditorView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
//

import SwiftUI
import AppKit

struct BodyEditorView: View {
    @Binding var selectedBodyType: BodyType
    @Binding var selectedBodyData: String
    
    var body: some View {
        VStack{
            Picker("Body Type:", selection: $selectedBodyType) {
                ForEach(BodyType.allCases) { bodyType in
                    Text(bodyType.friendlyName)
                }
            }
            TextEditor(text: $selectedBodyData)
                .font(.custom("AndaleMono", size: 12))
                .allowsTightening(false)
                .disabled($selectedBodyType.wrappedValue == BodyType.NONE)
                .opacity($selectedBodyType.wrappedValue == BodyType.NONE ? 0.5 : 1.0)
        }.padding()
    }
}

#Preview {
    BodyEditorView(selectedBodyType: .constant(BodyType.NONE), selectedBodyData: .constant("asdf"))
}
