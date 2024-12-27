//
//  ArabicAlphabetsView.swift
//  TVGames
//
//  Created by Saamer Mansoor on 12/26/24.
//

import SwiftUI
import AVFoundation

struct ArabicAlphabetsView: View {
    // List of Arabic alphabets
    let arabicAlphabets = [
        "ا", "ب", "ت", "ث", "ج", "ح", "خ", "د", "ذ", "ر", "ز", "س", "ش", "ص",
        "ض", "ط", "ظ", "ع", "غ", "ف", "ق", "ك", "ل", "م", "ن", "ه", "و", "ي"
    ]
    
    // AVSpeechSynthesizer for text-to-speech
    let synthesizer = AVSpeechSynthesizer()
    
    // Speak the tapped alphabet
    func speak(alphabet: String) {
        let utterance = AVSpeechUtterance(string: alphabet)
        utterance.voice = AVSpeechSynthesisVoice(language: "ar")
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Arabic Alphabets")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                        ForEach(arabicAlphabets, id: \.self) { alphabet in
                            Button(action: {
                                speak(alphabet: alphabet)
                            }) {
                                Text(alphabet)
                                    .font(.system(size: 40, weight: .bold))
                                    .frame(width: 80, height: 80)
                                    .background(LinearGradient(
                                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
                            }
                            .buttonStyle(PlainButtonStyle()) // For better appearance on Apple TV
                        }
                    }
                    .padding()
                }
                .background(Color(.gray).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

struct ArabicAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
        ArabicAlphabetsView()
    }
}
