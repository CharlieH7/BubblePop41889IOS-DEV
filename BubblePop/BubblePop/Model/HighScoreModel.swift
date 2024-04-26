//
//  HighScoreModel.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

import Foundation

struct HighScoreModel: Codable, Identifiable {
    var id = UUID()
    var playerName: String
    var highScore: Int
}
