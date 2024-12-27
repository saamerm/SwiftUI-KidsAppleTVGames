//
//  ContentView.swift
//  TVGames
//
//  Created by Saamer Mansoor on 12/24/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var synthesizer = AVSpeechSynthesizer()
    var body: some View {
        VStack {
            Button("Speak"){
                SpeakName()
            }
        }
        .padding()
    }
    
    func SpeakName(){
        let utterance = AVSpeechUtterance(string: "Hello")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
        
    }
}

#Preview {
    ContentView()
}
