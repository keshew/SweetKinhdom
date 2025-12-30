import SwiftUI

class ChocolateMeltViewModel: ObservableObject {
    let contact = ChocolateMeltModel()
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet: Int = 50

    @Published var isMelting = false
    @Published var multiplier: Double = 1.00
    @Published var gameResult: GameResult = .none
    @Published var showResult = false
    @Published var win = 0
    
    @Published var currentChocolateImage = "choco1"
    private var timer: Timer?
    private var gameDuration: TimeInterval = 10.0
    private var elapsedTime: TimeInterval = 0.0

    enum GameResult {
        case none, win, lose
    }

    func startGame() {
        guard coin >= bet else { return }
        isMelting = true
        showResult = false
        multiplier = 1.0
        gameResult = .none
        win = 0
        elapsedTime = 0.0
        currentChocolateImage = "choco1"

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateGame()
        }
    }

    func withdraw() {
        timer?.invalidate()
        isMelting = false
        gameResult = .win
        showResult = true
        updateCoins(true)
    }

    private func updateGame() {
        elapsedTime += 0.1
        
        let progress = elapsedTime / gameDuration
        multiplier = 1.0 + (4.0 * progress)
        
        if progress >= 0.66 {
            currentChocolateImage = "choco3"
        } else if progress >= 0.33 { 
            currentChocolateImage = "choco2"
        }
        
        if elapsedTime >= gameDuration || currentChocolateImage == "choco3" {
            timer?.invalidate()
            isMelting = false
            gameResult = .lose
            showResult = true
            updateCoins(false)
        }
    }

    private func updateCoins(_ won: Bool) {
        let payout = Int(Double(bet) * multiplier)

        if won {
            win = payout
            UserDefaultsManager.shared.recordWin(payout)
            coin = UserDefaultsManager.shared.coins
        } else {
            win = 0
            UserDefaultsManager.shared.recordLoss(bet)
            coin = UserDefaultsManager.shared.coins
        }

        UserDefaultsManager.shared.coins = coin
    }
}
