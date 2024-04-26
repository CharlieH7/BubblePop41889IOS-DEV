//
//  NewGameView.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var gameSession: GameSession
    
    @State private var gameTime: Double = 60.0 // Default game time in seconds
    @State private var numberOfBubbles: Double = 15 // Default number of bubbles

    var body: some View {
        VStack(spacing: 20) {
            Label("Settings", systemImage: "")
                .foregroundColor(.blue)
                .font(.largeTitle)
                .padding(.top, 25)
            
            // Player Name Input
            TextField("Enter Your Name", text: $gameSession.playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Game Time Slider
            VStack {
                Text("Game Time: \(Int(gameTime))s")
                    .foregroundColor(.blue)
                Slider(value: $gameTime, in: 10...60, step: 1)
            }
            .padding(.horizontal)
            
            // Number of Bubbles Slider
            VStack {
                Text("Number of Bubbles: \(Int(numberOfBubbles))")
                    .foregroundColor(.blue)
                Slider(value: $numberOfBubbles, in: 5...15, step: 1)
            }
            .padding(.horizontal)
            
            // Start Game Button
            NavigationLink(destination: StartGameView(gameViewModel: GameViewModel(maxBubbles: Int(numberOfBubbles), timeLeft: Int(gameTime), playerName: gameSession.playerName))) {
                Text("Start Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer() // Spacer at the bottom to push content up
        }
        .padding() // Add padding to the entire VStack
    }
}


#Preview {
    NewGameView()
}
