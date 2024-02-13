//
//  EditorSettingsView.swift
//  API Scout
//
//  Created by Lucas on 2/5/24.
//

import SwiftUI
import Highlightr

struct EditorSettingsView: View {
    @EnvironmentObject var editorSettings: EditorSettings
    
    var body: some View {
        let availableThemes = Highlightr.availableThemes(Highlightr()!)().sorted()

        let lightPickerName = if editorSettings.syncThemes {
            "Theme:"
        } else {
            "Light Theme:"
        }

        Form {
            Picker(lightPickerName, selection: $editorSettings.lightTheme) {
                ForEach(availableThemes, id: \.self) { themeName in
                    Text(themeName)
                }
            }
            
            if !editorSettings.syncThemes {
                Picker("Dark Theme:", selection: $editorSettings.darkTheme) {
                    ForEach(availableThemes, id: \.self) { themeName in
                        Text(themeName)
                    }
                }
            }
            
            Toggle(isOn: $editorSettings.syncThemes, label: {
                Text("Same theme for light and dark mode")
            })
        }.padding()
    }
}

#Preview {
    EditorSettingsView()
        .environmentObject(EditorSettings())
}
