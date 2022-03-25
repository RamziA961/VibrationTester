//
//  VibrationManager.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import Foundation
import AVFoundation
import LofeltHaptics
import UIKit

class VibrationManager {
    private var haptics : LofeltHaptics?
    private let audioPlayer : AVAudioPlayerNode
    private let audioEngine : AVAudioEngine
    
    init() {
        self.haptics = try? LofeltHaptics.init()
        self.audioEngine = AVAudioEngine()
        self.audioPlayer = AVAudioPlayerNode()
        
        self.audioEngine.attach(audioPlayer)
        
        self.audioPlayer.volume = 0
    }
    
    func playAudio() {
        if self.audioPlayer.volume == 0 {
            self.audioPlayer.volume = 1
        } else {
            self.audioPlayer.volume = 0
        }
    }
    
    func audioOn() -> Bool {
        return self.audioPlayer.volume == 1
    }
    
    func play(vibName: String) {
        
        let fileUrl = Bundle.main.url(forResource: vibName, withExtension: "wav")!
        
        let audioFile = try! AVAudioFile.init(forReading: fileUrl)
        
        self.audioEngine.connect(
            self.audioPlayer,
            to: self.audioEngine.mainMixerNode,
            format: audioFile.processingFormat
        )
        
        try! self.haptics?.attachAudioSource(self.audioPlayer)
        
        try! self.audioEngine.start()
    
        self.audioPlayer.scheduleFile(
            audioFile,
            at: nil,
            completionHandler: nil
        )
        
        self.audioPlayer.play()

//        try? haptics?.load(
//            NSString(
//                data: NSDataAsset(name: vibName)!.data,
//                encoding: String.Encoding.utf8.rawValue
//            )! as String
//        )
        
//        try? haptics?.play()
    }
}
