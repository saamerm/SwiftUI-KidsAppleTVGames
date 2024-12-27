//
//  Untitled.swift
//  TVGames
//
//  Created by Saamer Mansoor on 12/26/24.
//

import SwiftUI
import AVFoundation

struct AddTakeAwayTreatsView: View {
    @State private var numberOfCookies = 3
    @State private var operation: OperationType = .add
    @State private var operand = 0
    @State private var showingResult = false
    @State private var isCorrect = false
    @State private var userGuess = ""
    @State var synthesizer = AVSpeechSynthesizer()

    let cookieImage = "🍪" // Replace with an actual cookie image

    var correctAnswer: Int {
        switch operation {
        case .add:
            return numberOfCookies + operand
        case .subtract:
            return numberOfCookies - operand
        }
    }

    var instructionText: String {
        switch operation {
        case .add:
            return "How many cookies are there now?"
        case .subtract:
            return "How many cookies are left?"
        }
    }

    var actionDescription: String {
        switch operation {
        case .add:
            return "Look! \(operand) more cookies were added!"
        case .subtract:
            return "Uh oh! \(operand) cookies were eaten!"
        }
    }

    var body: some View {
        VStack {
            Text("Here are \(numberOfCookies) cookies.")
                .font(.title)
                .padding()

            LazyHStack {
                ForEach(0..<numberOfCookies, id: \.self) { _ in
//                    cookieImage
                    Text(cookieImage)
                        .font(.largeTitle)
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
                }
            }
//            .padding()

            Text(actionDescription)
                .font(.headline)
                .padding()
                .onAppear {
                    // Introduce the action after a short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        performOperation()
                    }
                }

            if showingResult {
                Text(isCorrect ? "🎉Great job!🥳" : "👎" + String(correctAnswer) + "! Try again!🙅‍♂️")
                    .font(.largeTitle)
                    .foregroundColor(isCorrect ? .green : .red)
//                    .padding()
            } else {
                Text(instructionText)
                    .font(.title2)
//                    .padding()

                HStack {
                    ForEach(0...10, id: \.self) { number in
                        Button("\(number)") {
                            checkAnswer(guess: number)
                        }
//                        .padding()
                    }
                }
            }

            if showingResult {
                Button("Next") {
                    resetGame()
                    read()

                }
//                .padding()
            }
        }
        .onAppear(){
            resetGame()
            read()
        } // Start with a new problem
    }
    
    func read(){
//        actionDescription
        let utterance = AVSpeechUtterance(string: "There were \(numberOfCookies) cookies. " + actionDescription + ". " + instructionText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)

    }

    func performOperation() {
        let operationChoice = Bool.random() // Randomly choose add or subtract
        operand = Int.random(in: 1...3) // Add or subtract a small number

        withAnimation(.easeInOut(duration: 1)) {
            if operationChoice {
                operation = .add
                numberOfCookies += operand
            } else if numberOfCookies >= operand { // Ensure we don't go negative
                operation = .subtract
                numberOfCookies -= operand
            } else {
                // If subtraction would go negative, default to adding
                operation = .add
                numberOfCookies += operand
            }
        }
    }

    func checkAnswer(guess: Int) {
        showingResult = true
        isCorrect = guess == correctAnswer
        // Play sound effect based on isCorrect (implementation needed)
    }

    func resetGame() {
        numberOfCookies = Int.random(in: 2...5) // Start with a new random number of cookies
        showingResult = false
        isCorrect = false
        performOperation() // Trigger the first operation
    }
}

enum OperationType {
    case add
    case subtract
}

struct AddTakeAwayTreatsView_Previews: PreviewProvider {
    static var previews: some View {
        AddTakeAwayTreatsView()
    }
}
