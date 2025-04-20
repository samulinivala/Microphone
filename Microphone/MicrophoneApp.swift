//
//  MicrophoneApp.swift
//  Microphone
//
//  Created by Samuli Nivala on 20.4.2025.
//

import SwiftUI

@main
struct MicrophoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
