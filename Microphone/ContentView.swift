//
//  ContentView.swift
//  Microphone
//
//  Created by Samuli Nivala on 20.4.2025.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = MicrophoneViewModel()
    @State private var isRequesting = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: viewModel.hasMicrophoneAccess ? "mic.fill" : "mic.slash.fill")
                .font(.system(size: 60))
                .foregroundColor(viewModel.hasMicrophoneAccess ? .green : .red)
            
            Text(viewModel.hasMicrophoneAccess ? "Microphone Access Granted" : "Microphone Access Denied")
                .font(.title2)
                .bold()
            
            if !viewModel.hasMicrophoneAccess {
                Button(action: {
                    print("ContentView: Request button tapped")
                    isRequesting = true
                    viewModel.requestMicrophoneAccess()
                    // Reset the requesting state after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isRequesting = false
                    }
                }) {
                    if isRequesting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Request Microphone Access")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isRequesting)
            }
        }
        .frame(minWidth: 300, minHeight: 200)
        .padding()
        .onAppear {
            print("ContentView: View appeared")
        }
    }
}

#Preview {
    ContentView()
}
