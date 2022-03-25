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

struct ContentView: View {
    
    @State var bgColor = Color.gray
    
    private let vibManager = VibrationManager()
    
    var body: some View {
        VStack{
            Button(action: {
                vibManager.playAudio()
                
                if vibManager.audioOn() {
                    bgColor = Color.green
                } else {
                    bgColor = Color.gray
                }
                
            }, label: {
                Text("Play Audio?")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8).fill(bgColor)                        .frame(minWidth: 100, maxWidth: .infinity)
                            .font(.largeTitle)
                    )
                    .foregroundColor(.white)
                    .frame(minWidth: 100, maxWidth: .infinity)
            })
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
