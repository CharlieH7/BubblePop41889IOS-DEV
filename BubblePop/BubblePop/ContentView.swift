//
//  ContentView.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameSession = GameSession()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("BubblePop")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            
                // Main Content VStack
                VStack {
                    Spacer()
                    
                    // Game Title
                    Text("BUBBLE POP!")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                        .padding(.bottom, 25)
                    
                    // New Game Button
                    NavigationLink(destination: NewGameView().environmentObject(gameSession)) {
                        Text("New Game")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    // High Score Button
                    NavigationLink(destination: HighScoreView()) {
                        Text("High Score")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitle("BUBBLE POP!", displayMode: .large)
        .environmentObject(gameSession)
    }
}


#Preview {
    ContentView()
}

