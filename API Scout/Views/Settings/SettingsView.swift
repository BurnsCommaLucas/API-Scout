//
//  SettingsView.swift
//  API Scout
//
//  Created by Lucas on 2/5/24.
//

import SwiftUI

struct SettingsView: View {

    private enum Tabs: Hashable {
        case general
        case editor
    }
    var body: some View {
        TabView {
            Text("")
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            EditorSettingsView()
                .tabItem {
                    Label("Editor", systemImage: "text.word.spacing")
                }
                .tag(Tabs.editor)
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}

#Preview {
    SettingsView()
        .environmentObject(EditorSettings())
}
