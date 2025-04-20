//
//  MicrophoneApp.swift
//  Microphone
//
//  Created by Samuli Nivala on 20.4.2025.
//

import SwiftUI

@main
struct MicrophoneApp: App {
    init() {
        // Make sure the usage description is set
        if Bundle.main.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") == nil {
            print("Warning: NSMicrophoneUsageDescription is not set in Info.plist")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
