    //
//  CountdownManager.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 30/12/21.
//

import SwiftUI

class CountdownManager: ObservableObject {
    @Published var secondsRemaining: Int = 0
    
    var completion: (() -> Void)?
    
    private var timer: Timer = Timer()
    
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
            } else {
                self.stop()
                self.completion?()
            }
        })
    }
    
    func stop() {
        timer.invalidate()
        secondsRemaining = 0
    }
    
    func pause() {
        timer.invalidate()
    }
}
