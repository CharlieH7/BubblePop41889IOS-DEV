//
//  HighScoreManager.swift
//  BubblePop
//
//  Created by Charlie Huang on 25/4/2024.
//

import Foundation

class HighScoreManager {
    private let highScoresKey = "highScores"

    // Save a new high score
    func saveHighScore(_ highScore: HighScoreModel) {
        var highScores = loadHighScores()
        highScores.append(highScore)
        saveHighScores(highScores)
    }

    // Load high scores from UserDefaults
    func loadHighScores() -> [HighScoreModel] {
        guard let data = UserDefaults.standard.data(forKey: highScoresKey) else {
            return []
        }
        if let decoded = try? JSONDecoder().decode([HighScoreModel].self, from: data) {
            return decoded
        }
        return []
    }
    
    func resetHighScores() {
        // Reset high scores by setting an empty array in UserDefaults
        UserDefaults.standard.removeObject(forKey: highScoresKey)
    }
    
    // Save high scores to UserDefaults
    private func saveHighScores(_ highScores: [HighScoreModel]) {
        if let encoded = try? JSONEncoder().encode(highScores) {
            UserDefaults.standard.set(encoded, forKey: highScoresKey)
        }
    }
}
