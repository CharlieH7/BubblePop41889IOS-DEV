//
//  GameViewModel.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

// HighScoreManager.swift
// Manages saving and loading high scores from UserDefaults

// GameViewModel.swift
// Manages the game logic and data for the BubblePop game

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var bubbles: [BubbleModel] = [] // Array to hold bubbles on the screen
    @Published var timeLeft: Int // Remaining time in the game
    @Published var score: Int = 0 // Player's score
    @Published var highScore: Int = UserDefaults.standard.integer(forKey: "highScore") // Highest score achieved
    @StateObject private var gameSession = GameSession() // Game session information
    
    private var maxBubbles: Int // Maximum number of bubbles allowed
    private var timer: Timer? // Timer for game countdown
    private var playerName: String // Name of the player
    
    // Initialize the game with specified parameters
    init(maxBubbles: Int, timeLeft: Int, playerName: String) {
        self.maxBubbles = maxBubbles
        self.timeLeft = timeLeft + 4 // Add extra time to compensate for countdown
        self.playerName = playerName
        generateBubbles(count: maxBubbles) // Generate bubbles for the game
    }
    
    // Start the game
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeLeft > 0 {
                self.timeLeft -= 1 // Decrease time left by 1 second
                self.refreshBubbles() // Refresh bubbles every game second
            } else {
                self.endGame(playerName: self.playerName) // End the game if time runs out
            }
        }
    }
    
    // End the game and update high scores
    func endGame(playerName: String) {
        timer?.invalidate() // Stop the timer
        if score > highScore {
            highScore = score // Update high score
            UserDefaults.standard.set(highScore, forKey: "highScore") // Save high score to UserDefaults
            let highScoreEntry = HighScoreModel(playerName: playerName, highScore: highScore)
            HighScoreManager().saveHighScore(highScoreEntry) // Save high score entry
        }
        // Update gameSession highScore if it's higher
        if score > gameSession.highScore {
            gameSession.highScore = score
        }
    }
    
    // Pop a bubble and update score
    func popBubble(_ bubble: BubbleModel) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            let basePoints = bubble.value
            let consecutiveMultiplier = bubbles.prefix(index).filter({ $0.color == bubble.color }).count
            let pointsEarned = Int(Double(basePoints) * pow(1.5, Double(consecutiveMultiplier)))
            score += pointsEarned // Increase score
            bubbles.remove(at: index) // Remove popped bubble from the array
        }
    }
    
    // Generate bubbles with random colors and positions
    private func generateBubbles(count: Int) {
        let bubbleColors: [Color] = [.red, .pink, .green, .blue, .black]
        
        let bubbleSize: CGFloat = 100.0
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<count {
            let randomColor = bubbleColors.randomElement() ?? .red // Default to red if no color is selected
            var bubble = BubbleModel()
            
            // Generate random positions across the entire screen
            let randomX = CGFloat.random(in: 0...screenWidth - bubbleSize)
            let randomY = CGFloat.random(in: 0...screenHeight - bubbleSize)
            
            bubble.position = CGPoint(x: randomX, y: randomY)
            bubbles.append(bubble) // Add bubble to the array
        }
    }
    
    // Refresh bubbles by removing some and adding new ones
    private func refreshBubbles() {
        // Remove a random number of bubbles (excluding popped bubbles)
        let bubblesToRemove = Int.random(in: 1...(bubbles.count / 2))
        for _ in 0..<bubblesToRemove {
            if let index = bubbles.indices.randomElement() {
                bubbles.remove(at: index)
            }
        }
        // Add new bubbles to reach maxBubbles count
        let newBubblesCount = maxBubbles - bubbles.count
        if newBubblesCount > 0 {
            generateBubbles(count: newBubblesCount)
        }
    }
    
    // Model representing a bubble on the screen
    class BubbleModel: Identifiable, ObservableObject {
        let id = UUID() // Unique identifier for the bubble
        let color: Color // Color of the bubble
        let value: Int // Value of the bubble
        @Published var position: CGPoint // Position of the bubble
        
        // Initialize bubble with random color and position
        init() {
            let possibility = Int.random(in: 1...100)
            
            switch possibility {
            case 1...40:
                self.color = Color.red
                self.value = 1
            case 41...70:
                self.color = Color.pink
                self.value = 2
            case 71...85:
                self.color = Color.green
                self.value = 5
            case 86...95:
                self.color = Color.blue
                self.value = 8
            case 96...100:
                self.color = Color.black
                self.value = 10
            default:
                self.color = Color.red
                self.value = 1
            }
            
            // Initialize position with zero point initially
            self.position = .zero
        }
    }
}


