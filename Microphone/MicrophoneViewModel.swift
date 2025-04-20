import Foundation
import AVFoundation

class MicrophoneViewModel: ObservableObject {
    @Published var hasMicrophoneAccess: Bool = false
    private var audioSession: AVCaptureSession?
    
    init() {
        print("MicrophoneViewModel: Initializing")
        checkMicrophoneAccess()
    }
    
    func checkMicrophoneAccess() {
        print("MicrophoneViewModel: Checking microphone access")
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        print("MicrophoneViewModel: Current status - \(status)")
        
        switch status {
        case .authorized:
            print("MicrophoneViewModel: Access already authorized")
            hasMicrophoneAccess = true
            setupAudioSession()
        case .notDetermined:
            print("MicrophoneViewModel: Access not determined, requesting...")
            requestMicrophoneAccess()
        case .denied:
            print("MicrophoneViewModel: Access denied")
            hasMicrophoneAccess = false
        case .restricted:
            print("MicrophoneViewModel: Access restricted")
            hasMicrophoneAccess = false
        @unknown default:
            print("MicrophoneViewModel: Unknown status")
            hasMicrophoneAccess = false
        }
    }
    
    private func setupAudioSession() {
        print("MicrophoneViewModel: Setting up audio session")
        audioSession = AVCaptureSession()
        
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
            print("MicrophoneViewModel: No audio device found")
            return
        }
        
        do {
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            if audioSession?.canAddInput(audioInput) == true {
                audioSession?.addInput(audioInput)
                print("MicrophoneViewModel: Audio input added to session")
            }
        } catch {
            print("MicrophoneViewModel: Error setting up audio input: \(error)")
        }
    }
    
    func requestMicrophoneAccess() {
        print("MicrophoneViewModel: Requesting microphone access")
        
        // Request permission before setting up the session
        AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
            print("MicrophoneViewModel: Access request completed - granted: \(granted)")
            DispatchQueue.main.async {
                self?.hasMicrophoneAccess = granted
                if granted {
                    self?.setupAudioSession()
                }
            }
        }
    }
} 