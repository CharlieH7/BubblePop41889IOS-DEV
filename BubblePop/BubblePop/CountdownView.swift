//
//  CountdownView.swift
//  BubblePop
//
//  Created by Charlie Huang on 26/4/2024.
//

import SwiftUI

struct CountdownView: View {
    let countdown: [String] = ["3", "2", "1", "Start!"]
    @State private var currentIndex = 0
    @State private var isAnimating = false
    @Binding var isCountdownFinished: Bool

    var body: some View {
        ZStack {
            Color.yellow // Background color
                .edgesIgnoringSafeArea(.all)

            Text(countdown[currentIndex])
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .scaleEffect(isAnimating ? 1.5 : 1)
                .onAppear {
                    animateCountdown()
                }
        }
    }

    func animateCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.currentIndex < self.countdown.count - 1 {
                self.currentIndex += 1
                withAnimation {
                    self.isAnimating.toggle()
                }
            } else {
                timer.invalidate()
                // Update isCountdownFinished when countdown finishes
                self.isCountdownFinished = true
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(isCountdownFinished: .constant(false))
    }
}
