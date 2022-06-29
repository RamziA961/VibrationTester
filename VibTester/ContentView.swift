//
//  ContentView.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import SwiftUI


private let vibrations : [String: [String]] = [
    "Engine": ["v-09-11-3-24", "v-09-11-3-8"],
    "Animal": ["v-09-12-1-19", "v-10-28-7-35"],
    "Walking": ["v-10-10-1-10", "v-09-12-2-40"],
    "Heartbeat": ["v-09-18-1-55", "v-09-10-4-20"],
    "Tapping": ["v-09-10-7-9", "v-09-11-4-8"],
    "Jumping": ["v-09-11-3-50", "v-10-28-7-31"],
    "Alarm": ["v-09-11-3-12", "v-10-21-3-45"]
]

struct ContentView: View {
    
    private let vibManager = VibrationManager()
    
    var body: some View {
        VStack{
//            AudioToggle(audioOn: vibManager.audioOn, toggleAudio: vibManager.playAudio)
        
            ScrollView {
                VStack {
                    
                    ForEach(Array(vibrations.keys), id: \.self) { key in
                        ButtonRow(
                            groupName: key,
                            vibNames: vibrations[key]!,
                            vibManager: vibManager
                        )
                        Spacer()
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 8")
        }
    }
}
