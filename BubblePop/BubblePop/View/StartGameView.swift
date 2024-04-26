//
//  StartGameView.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

import SwiftUI

struct StartGameView: View {
    @EnvironmentObject var gameSession: GameSession
    @ObservedObject var gameViewModel: GameViewModel
    @State private var isGameFinished: Bool = false // State variable to track if the game has ended
    @State private var isCountdownFinished = false

    var body: some View {
        NavigationView {
            VStack {
                // Countdown View
                if !isCountdownFinished {
                    CountdownView(isCountdownFinished: $isCountdownFinished)
                } else {
                    HStack {
                        Text("Time Left: \(gameViewModel.timeLeft)")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Text("Score: \(gameViewModel.score)")
                            .font(.headline)
                            .padding(.trailing)
                        
                        Text("High Score: \(gameSession.highScore)")
                            .font(.headline)
                            .padding(.trailing)
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    // Display bubbles using BubbleModel objects from gameViewModel
                    ForEach(gameViewModel.bubbles) { bubble in
                        Circle()
                            .fill(bubble.color)
                            .frame(width: 50, height: 50)
                            .position(bubble.position)
                            .onTapGesture {
                                gameViewModel.popBubble(bubble)
                            }
                    }
                }
            }
            .onAppear {
                gameViewModel.startGame() // Start the game when view appears
            }
            .onReceive(gameViewModel.$timeLeft) { timeLeft in
                if timeLeft == 0 && !isGameFinished {
                    endGameAndNavigate()
                }
            }
            .background(Color.yellow)
            .navigationBarItems(trailing: EmptyView())
            .background(
                NavigationLink(destination: HighScoreView(), isActive: $isGameFinished) { // Activate link based on isGameFinished
                    EmptyView() // NavigationLink content is empty
                }
                .hidden() // Hide the navigation link button
            )
            .onReceive(gameSession.$highScore) { newHighScore in
                // Update highest score displayed dynamically
                if newHighScore > gameViewModel.highScore {
                    gameViewModel.highScore = newHighScore
                }
            }
        }
    }
    
    private func endGameAndNavigate() {
        isGameFinished = true // Set isGameFinished to true once
        gameViewModel.endGame(playerName: gameSession.playerName)
        if gameViewModel.score > gameSession.highScore {
            gameSession.highScore = gameViewModel.score
            HighScoreManager().saveHighScore(HighScoreModel(playerName: gameSession.playerName, highScore: gameSession.highScore))
        }
    }
}

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView(gameViewModel: GameViewModel(maxBubbles: 10, timeLeft: 10, playerName: "Charlie"))
            .environmentObject(GameSession()) // Provide a sample GameViewModel with timeLeft = 0 for testing
    }
}
