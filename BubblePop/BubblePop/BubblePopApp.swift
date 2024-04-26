//
//  BubblePopApp.swift
//  BubblePop
//
//  Created by Charlie Huang on 24/4/2024.
//

import SwiftUI

@main
struct BubblePopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GameSession())
                .navigationViewStyle(StackNavigationViewStyle())

        }
    }
}
