//
//  ContentView.swift
//  VibTester
//
//  Created by Ramzi Abou Chahine on 3/22/22.
//

import SwiftUI


private let vibrations = [
    "v-50-100-0",
    "v-50-100-8",
    "v-50-150-0",
    "v-50-150-8",
    "v-50-200-0",
    "v-50-200-8",
    
    "v-300-100-0",
    "v-300-100-8",
    "v-300-150-0",
    "v-300-150-8",
    "v-300-200-0",
    "v-300-200-8",
    
    "v-2000-100-0",
    "v-2000-100-8",
    "v-2000-150-0",
    "v-2000-150-8",
    "v-2000-200-0",
    "v-2000-200-8"
]

struct AudioToggle : View {
    
    @State var bgColor = Color.gray
    @State var text = "Activate Audio"
    
    private let audioOn : () -> Bool
    private let toggleAudio : () -> Void

    init(audioOn: @escaping () -> Bool, toggleAudio : @escaping () -> Void) {
        self.audioOn = audioOn
        self.toggleAudio = toggleAudio
    }
    
    var body : some View {
        Button(action: {
            toggleAudio()
    
            if audioOn() {
                bgColor = Color.green
                text = "Deactivate Audio"
            } else {
                bgColor = Color.gray
                text = "Activate Audio"
            }}, label: {
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

struct ContentView: View {
    
    private let vibManager = VibrationManager()
    
    var body: some View {
        VStack{
            AudioToggle(audioOn: vibManager.audioOn, toggleAudio: vibManager.playAudio)
        
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
