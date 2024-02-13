//
//  API_ScoutApp.swift
//  API Scout
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI
import SwiftData

@main
struct API_ScoutApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Request.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        let editorSettings = EditorSettings()
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(editorSettings)
        .commands {
            CommandGroup(after: .newItem) {
                Divider()
                Button("Save") {
                    do {
                        try sharedModelContainer.mainContext.save()
                    } catch {}
                }.keyboardShortcut(KeyEquivalent("s"), modifiers: EventModifiers.command)
            }
        }
        
        Settings {
            SettingsView()
        }
        .environmentObject(editorSettings)
    }
}
