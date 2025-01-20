import SwiftUI
import UIKit

struct RocketRunnerGameView: View {
    @State private var rocketPosition = CGFloat(0)
    @State private var obstacles: [Obstacle] = []
    @State private var gameOver = false
    @State private var score = 0
    @State private var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var timer: Timer?
    @State private var gameSpeed = 0.02
    
    @FocusState private var isFocused
    let rocketSize: CGFloat = 60
    let obstacleSize: CGFloat = 60
    let movementStep: CGFloat = 50 // Step size for rocket movement

    struct Obstacle: Identifiable {
        let id = UUID()
        var position: CGSize
    }

    var body: some View {
        ZStack {
            // Background Color
            Color.purple
                .opacity(0.3).edgesIgnoringSafeArea(.all)

            
            VStack {
                // Current Score
                Text("Score: \(score)")
                    .foregroundColor(.pink)
                    .font(.headline)
                    .padding()
                
                // High Score
                Text("High Score: \(highScore)")
                    .foregroundColor(.yellow)
                    .font(.subheadline)
                
                Spacer()
            }
            
            // Rocket (Star)
            Button("\(Image(systemName: "star.fill"))"){
                
            }
//            Image(systemName: "star.fill")
                .scaledToFit()
                .frame(width: rocketSize, height: rocketSize)
                .position(x: UIScreen.main.bounds.width / 2 + rocketPosition, y: UIScreen.main.bounds.height - rocketSize)
                .onMoveCommand(perform: { direction in
                    guard !gameOver else { return }
                    switch direction {
                        case .left:
                        print("move")
                            rocketPosition = max(rocketPosition - movementStep, -UIScreen.main.bounds.width / 2 + rocketSize / 2)
                        case .right:
                            rocketPosition = min(rocketPosition + movementStep, UIScreen.main.bounds.width / 2 - rocketSize / 2)
                        @unknown default:
                            fatalError()
                    }
                })
            
            // Obstacles (Emoji Roses)
            ForEach(obstacles) { obstacle in
                Text("🌹") // Using rose emoji for obstacles
                    .font(.system(size: obstacleSize))
                    .position(x: obstacle.position.width, y: obstacle.position.height)
            }
            
            // Game Over Text
            if gameOver {
                VStack {
                    Text("Game Over!")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .padding()
                    
                    Text("Your Score: \(score)")
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    Button("Restart") {
                        restartGame()
                    }
                    .focused($isFocused)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .onAppear {
            startGame()
        }
    }

    func startGame() {
        gameSpeed = 0.02
        obstacles = []
        gameOver = false
        score = 0
        rocketPosition = 0
        timer = Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: true) { _ in
            updateGame()
        }
    }

    func updateGame() {
        // Move obstacles down
        for i in obstacles.indices {
            obstacles[i].position.height += 5
        }

        // Remove off-screen obstacles
        obstacles.removeAll { $0.position.height > UIScreen.main.bounds.height }

        // Add new obstacles
        if Int.random(in: 0..<50) == 0 {
            let xPosition = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            obstacles.append(Obstacle(position: CGSize(width: xPosition, height: -obstacleSize)))
        }

        // Check collisions
        for obstacle in obstacles {
            if abs(obstacle.position.width - (UIScreen.main.bounds.width / 2 + rocketPosition)) < obstacleSize &&
                abs(obstacle.position.height - (UIScreen.main.bounds.height - rocketSize)) < obstacleSize {
                endGame()
            }
        }

        // Increment score
        score += 1
//        Logic doesnt work
//        if score > 500 && score < 1000 && gameSpeed != 0.01 {
//            gameSpeed = 0.01
//        } else if score >= 1000 && score < 1500 && gameSpeed != 0.0075 {
//            gameSpeed = 0.0075
//        } else if score >= 1500 && score < 2000 && gameSpeed != 0.005 {
//            gameSpeed = 0.005
//        } else if score >= 2000 && score < 2500 && gameSpeed != 0.0025 {
//            gameSpeed = 0.0025
//        } else if score >= 2500 && gameSpeed != 0.001 {
//            gameSpeed = 0.001
//        }
    }

    func endGame() {
        gameOver = true
        timer?.invalidate()
        isFocused = true
        // Check and update high score
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        }
    }

    func restartGame() {
        startGame()
    }
}

struct RocketRunnerGameView_Previews: PreviewProvider {
    static var previews: some View {
        RocketRunnerGameView()
    }
}
