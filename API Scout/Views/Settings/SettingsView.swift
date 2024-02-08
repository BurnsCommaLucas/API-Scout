//
//  SettingsView.swift
//  API Scout
//
//  Created by Lucas on 2/5/24.
//

import SwiftUI

struct SettingsView: View {

    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            Text("")
                .tabItem {
                    Label("Advanced", systemImage: "star")
                }
                .tag(Tabs.advanced)
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}

#Preview {
    SettingsView()
        .environmentObject(GeneralSettings())
}
