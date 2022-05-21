//
//  ContentView.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import SwiftUI


private let vibrations = [
   "v-80-0-300",
   "v-80-0-2000",
   "v-80-8-300",
   "v-80-8-2000",
   "v-155-0-300",
   "v-155-0-2000",
   "v-155-8-300",
   "v-155-8-2000",
   "v-230-0-300",
   "v-230-0-2000",
   "v-230-8-300",
   "v-230-8-2000",
]

struct ContentView: View {
    
    private let vibManager = VibrationManager()
    
    var body: some View {
        VStack{
//            AudioToggle(audioOn: vibManager.audioOn, toggleAudio: vibManager.playAudio)
        
            ScrollView {
                VStack {
                    ForEach(0..<(vibrations.count / 3), id: \.self) { index in
                        ButtonRow(
                            vibNames: Array(vibrations[(3 * index)..<(3 * index + 3)]),
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
