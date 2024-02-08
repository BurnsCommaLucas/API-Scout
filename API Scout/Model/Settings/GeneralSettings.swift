//
//  GeneralSettings.swift
//  API Scout
//
//  Created by Lucas on 2/7/24.
//

import Foundation
import SwiftUI
import CodeEditor

class GeneralSettings: ObservableObject {
    @AppStorage("lightTheme") var lightTheme = "a11y-light"
    @AppStorage("darkTheme") var darkTheme = "a11y-dark"
    @AppStorage("syncThemes") var syncThemes = false
    
    func currentThemeName(colorScheme: ColorScheme) -> CodeEditor.ThemeName {
        switch colorScheme {
        case .dark:
            return CodeEditor.ThemeName(rawValue: syncThemes ? lightTheme : darkTheme)
        case .light:
            return CodeEditor.ThemeName(rawValue: lightTheme)
        default:
            return CodeEditor.ThemeName(rawValue: lightTheme)
        }
    }
}
