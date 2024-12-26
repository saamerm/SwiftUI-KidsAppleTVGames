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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Speak"){
                SpeakName()
            }
        }
        .padding()
    }
    
    func SpeakName(){
        synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "Hello")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            synthesizer.speak(utterance)
        }
    }
}

#Preview {
    ContentView()
}
