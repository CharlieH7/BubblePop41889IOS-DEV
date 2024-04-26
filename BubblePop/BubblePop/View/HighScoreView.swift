//
//  HighScoreView.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

import SwiftUI

struct HighScoreView: View {
    @EnvironmentObject var gameSession: GameSession
    @State private var highScores: [HighScoreModel] = []
    @State private var isConfirmingReset = false

    var body: some View {
        VStack {
            Text("High Scores")
                .font(.title)
            
            Button(action: {
                isConfirmingReset = true
            }) {
                Text("Reset High Scores")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .alert(isPresented: $isConfirmingReset) {
                Alert(
                    title: Text("Confirm Reset"),
                    message: Text("Are you sure you want to reset high scores?"),
                    primaryButton: .default(Text("Reset")) {
                        resetHighScores()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            List(highScores.sorted(by: { $0.highScore > $1.highScore }).prefix(3)) { score in
                HStack {
                    Text(score.playerName)
                    Spacer()
                    Text("\(score.highScore)")
                }
            }
        }
        .onAppear {
            // Load high scores from UserDefaults using HighScoreManager
            highScores = HighScoreManager().loadHighScores()
        }
    }

    private func resetHighScores() {
        HighScoreManager().resetHighScores()
        highScores.removeAll()
    }
}


struct HighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreView()
    }
}
