//
//  GeneralSettings.swift
//  API Scout
//
//  Created by Lucas on 2/5/24.
//

import SwiftUI
import Highlightr

struct GeneralSettingsView: View {
    @EnvironmentObject var generalSettings: GeneralSettings
    
    var body: some View {
        let availableThemes = Highlightr.availableThemes(Highlightr()!)().sorted()

        let lightPickerName = if generalSettings.syncThemes {
            "Theme:"
        } else {
            "Light Theme:"
        }

        Form {
            Picker(lightPickerName, selection: $generalSettings.lightTheme) {
                ForEach(availableThemes, id: \.self) { themeName in
                    Text(themeName)
                }
            }
            
            if !generalSettings.syncThemes {
                Picker("Dark Theme:", selection: $generalSettings.darkTheme) {
                    ForEach(availableThemes, id: \.self) { themeName in
                        Text(themeName)
                    }
                }
            }
            
            Toggle(isOn: $generalSettings.syncThemes, label: {
                Text("Same theme for light and dark mode")
            })
        }.padding()
    }
}

#Preview {
    GeneralSettingsView()
        .environmentObject(GeneralSettings())
}
