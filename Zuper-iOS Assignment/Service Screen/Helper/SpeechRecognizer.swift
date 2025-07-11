//
//  SpeechRecognizer.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//


import Foundation
import Speech
import Combine

class SpeechRecognizer: NSObject, ObservableObject {
    private let recognizer = SFSpeechRecognizer()
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    @Published var transcribedText: String = ""

    override init() {
        super.init()
        requestPermissions()
    }

    private func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { _ in }
        AVAudioSession.sharedInstance().requestRecordPermission { _ in }
    }

    func startTranscribing() {
        try? startSession()
    }

    func stopTranscribing() {
        audioEngine.stop()
        request?.endAudio()
        recognitionTask?.cancel()
    }

    private func startSession() throws {
        transcribedText = ""
        recognitionTask?.cancel()
        request = SFSpeechAudioBufferRecognitionRequest()

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        let inputNode = audioEngine.inputNode

        guard let request = request else { fatalError("Speech request failed.") }

        recognitionTask = recognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.transcribedText = result.bestTranscription.formattedString
                }
            }
        }

        let format = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            self.request?.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }
}
