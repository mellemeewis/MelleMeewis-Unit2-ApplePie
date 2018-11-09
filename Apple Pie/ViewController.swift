//
//  ViewController.swift
//  Apple Pie
//
//  Created by Melle Meewis on 09/11/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var listOfWords = ["beunhaasen", "appel", "banaan", "amsterdam", "nederland", "voetbal", "hockey", "student", "muchachomel", "hond", "kat"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        // keep track of wins and start new round
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        // keep track of losses and start new round
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    
    func newRound() {
        // start new round if more words available
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            updateUI()
            enableLetterButtons(true)
        }
        else {
            updateUI()
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        // handle enabling of disbling letters at and of round
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        // update user interface
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        // update game statistics
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }
    }

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // handle buttons being pressed
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
}

