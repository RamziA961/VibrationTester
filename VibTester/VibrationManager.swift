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
    private var vibEnd : Double?
//    private var vibPatterns : [String: CHHapticPattern]?
    private var subjectivePatterns : [String: CHHapticPattern]?
    private var objectivePatterns : [String: CHHapticPattern]?
        
    init(_ vibrations : [String]) {
        
//        self.vibPatterns = [:]
        self.objectivePatterns = [:]
        self.subjectivePatterns = [:]
        self.vibEnd = 0.0
        
        for vibName in vibrations {
//        if let path = Bundle.main.path(forResource: vibName, ofType: "ahap") {
//            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let json = try! JSONSerialization.jsonObject(with: data)
//
//            if let jsonResult = json as? Dictionary<CHHapticPattern.Key, Any> {
//                vibPatterns?[vibName] = try! CHHapticPattern.init(dictionary: jsonResult)
//            }
//
//        } else {
//            print("File not found.")
//        }
            
            if let path = Bundle.main.url(forResource: "Subjective/\(vibName)", withExtension: "ahap")?.path {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try! JSONSerialization.jsonObject(with: data)
                
                if let jsonResult = json as? Dictionary<CHHapticPattern.Key, Any> {
                    subjectivePatterns?[vibName] = try! CHHapticPattern.init(dictionary: jsonResult)
                }
                
            } else {
                print("File not found.")
            }
            
            if let path = Bundle.main.url(forResource: "Objective/\(vibName)", withExtension: "ahap")?.path {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try! JSONSerialization.jsonObject(with: data)
                
                if let jsonResult = json as? Dictionary<CHHapticPattern.Key, Any> {
                    objectivePatterns?[vibName] = try! CHHapticPattern.init(dictionary: jsonResult)
                }
                
            } else {
                print("File not found.")
            }
        }
        
        
        if (CHHapticEngine.capabilitiesForHardware().supportsHaptics) {
            do {
                self.haptics = try CHHapticEngine()
                try self.haptics?.start()
            } catch let error {
                print(error)
            }
        }
    }
    
    
    func play(vibName: String, objective: Bool?) -> Bool {
        let currTime = CFAbsoluteTimeGetCurrent()
        
        if vibEnd != 0 && currTime < vibEnd! + 0.1 {
            return false
        }
        
        if objective != nil && objective! {
            vibEnd = currTime + (objectivePatterns?[vibName]!.duration)!
            try? self.haptics?.makePlayer(with: (objectivePatterns?[vibName])!).start(atTime: 0)
        } else {
            vibEnd = currTime + (subjectivePatterns?[vibName]!.duration)!
            try? self.haptics?.makePlayer(with: (subjectivePatterns?[vibName])!).start(atTime: 0)
        }
//        vibEnd = currTime + (vibPatterns?[vibName]!.duration)! //adjust vibration termination time

        return true
        
//        guard let path = Bundle.main.url(forResource: vibName, withExtension: "ahap") else {
//            print("Not Found")
//            return
//        }
//        try? self.haptics?.playPattern(from: path)
    }
    
    func getVibrationEndTime() -> Double {
        if vibEnd! != 0 {
            let currTime = CFAbsoluteTimeGetCurrent()
    
            return vibEnd! - currTime
        }
        
        return 0
    }
}
