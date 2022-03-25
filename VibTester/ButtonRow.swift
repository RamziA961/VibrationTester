//
//  ButtonRow.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import SwiftUI

struct ButtonRow : View {
    
    private let vibNames : [String]
    private let vibManager : VibrationManager
    
    init(vibNames: [String], vibManager: VibrationManager) {
        self.vibNames = vibNames
        self.vibManager = vibManager
    }
    
    var body : some View {
        HStack{
            ForEach(vibNames, id: \.self) {name in
                PlayButton(text: name, vibManager: vibManager)
                
                if name != vibNames.last {
                    Spacer()
                }
            }
        }
        .padding()
    }
}
