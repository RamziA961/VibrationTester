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

    @State private var bgColor = Color.blue
    
    init(text : String, vibManager: VibrationManager) {
        self.text = text
        self.vibManager = vibManager
    }

    var body : some View {
        Button(action: {
            vibManager.play(vibName: text)
            bgColor = Color.gray
        }, label: {
            Text(text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(bgColor)                        .frame(minWidth: 100, maxWidth: .infinity)
                        .font(.largeTitle)
                )
                .foregroundColor(.white)
                .frame(minWidth: 100, maxWidth: .infinity)
        })
    }
}
