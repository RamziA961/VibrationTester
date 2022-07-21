//
//  ButtonRow.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import SwiftUI

struct ButtonRow : View {
    private let objective : Bool
    private let groupName : String
    private let vibNames : [String]
    private let vibManager : VibrationManager

    
    init(groupName: String, vibNames: [String], vibManager: VibrationManager, objective: Bool) {
        self.objective = objective
        self.groupName = groupName
        self.vibNames = vibNames
        self.vibManager = vibManager
    }
    
    var body : some View {
        Section(header: Text(self.groupName)) {
            HStack{
                ForEach(vibNames, id: \.self) {name in
                    PlayButton(text: name, vibManager: vibManager, objective : self.objective)
                    
                    if name != vibNames.last {
                        Spacer()
                    }
                }
            }
            .padding()
        }
        Spacer()
    }
}
