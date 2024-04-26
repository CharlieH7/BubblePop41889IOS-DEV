//
//  GameSession.swift
//  BubblePop
//
//  Created by Charlie Huang on 25/4/2024.
//

import SwiftUI

class GameSession: ObservableObject {
    @Published var playerName: String = ""
    @Published var highScore: Int = 0
}
