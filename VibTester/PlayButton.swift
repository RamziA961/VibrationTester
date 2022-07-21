//
//  PlayButton.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import Foundation
import SwiftUI


struct PlayButton : View {
    private var text : String
    private var vibManager : VibrationManager
    private var objective : Bool
    
    @State private var bgColor = Color.blue
    
    init(text : String, vibManager: VibrationManager, objective: Bool) {
        self.text = text
        self.vibManager = vibManager
        self.objective = objective
    }

    var body : some View {
        Button(action: {
            let playing = vibManager.play(vibName: text, objective: objective)
            
            if playing {
                bgColor = Color.green
                
                DispatchQueue.main.asyncAfter(deadline: .now() + vibManager.getVibrationEndTime()) {
                    bgColor = Color.gray
                }
            }
        }, label: {
            Text(text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(bgColor)
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .font(.largeTitle)
                )
                .foregroundColor(.white)
                .frame(minWidth: 100, maxWidth: .infinity)
        })
    }
}
