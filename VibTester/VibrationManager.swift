//
//  VibrationManager.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import Foundation
import UIKit
import CoreHaptics

class VibrationManager {
    private var haptics : CHHapticEngine?
        
    init() {
        self.haptics = nil
        
        if (CHHapticEngine.capabilitiesForHardware().supportsHaptics) {
            do {
                self.haptics = try CHHapticEngine()
                try self.haptics?.start()
            } catch let error {
                print(error)
            }
        }
    }
    
    
    func play(vibName: String) {
        guard let path = Bundle.main.url(forResource: vibName, withExtension: "ahap") else {
            print("Not Found")
            return
        }
        
        try? self.haptics?.playPattern(from: path)
    }
}
