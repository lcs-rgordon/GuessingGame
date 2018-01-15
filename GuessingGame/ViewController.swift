//
//  ViewController.swift
//  GuessingGame
//
//  Created by Gordon, Russell on 2018-01-09.
//  Copyright © 2018 Gordon, Russell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var guessedNumber: UITextField!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var guessTracker: UILabel!
    
    // MARK: Properties
    var targetNumber : Int = -1
    var lowestGuessCountEver = Int.max  // Set the lowest guess count to the highest possible integer value to begin with
    var guessCountForThisRound = 0      // No guesses so far...
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: New methods
    @IBAction func checkGuess(_ sender: Any) {
        
        print("A guess was made.")
        print(guessedNumber.text)
        
        // Unwrap the optional
        guard let providedInput = guessedNumber.text else {
            return // Could not unwrap optional
        }
        
        // Now try to create an integer
        guard let guess = Int(providedInput) else {
            instructionsLabel.text = instructionsLabel.text! + "\n\nA number, please."
            return
        }
        
        // Check the guess
        updateGuessCount()
        if guess == targetNumber {
            endGame()
        } else if guess > targetNumber {
            instructionsLabel.text = "Guess lower."
        } else {
            instructionsLabel.text = "Guess higher."
        }
        
    }
    
    // End the game and ask whether user wants to play again
    func endGame() {
        guessButton.isHidden = true
        playAgainButton.isHidden = false
        guessedNumber.isEnabled = false
        
        // Is this a new record?
        if guessCountForThisRound < lowestGuessCountEver {
            instructionsLabel.text = """
            You got it!
            
            New record!
            Only \(guessCountForThisRound) guesses.
            """
            
            // Report prior best, if there was one
            if lowestGuessCountEver != Int.max {
                instructionsLabel.text = instructionsLabel.text! + "\n\nPrior best was \(lowestGuessCountEver)."
            }

            // Update best ever
            lowestGuessCountEver = guessCountForThisRound
        } else {
            instructionsLabel.text = "You got it!"
        }

        
    }
    
    // Start a new game
    @IBAction func startNewGame(_ sender: Any) {
        
        // Generate a number for the player to guess
        targetNumber = 2//Int(arc4random_uniform(1001)) // Produce a number between 1 and 1000, inclusive (but not 1001)
        
        // Reset the interface and game
        playAgainButton.isHidden = true
        guessButton.isHidden = false
        guessedNumber.isEnabled = true
        instructionsLabel.text = "I'm thinking of a number\nbetween 0 and 1000.\n\nGuess it!\n\n"
        guessedNumber.text = ""
        guessTracker.text = "0 guesses made."
        
        // Reset best guess count
        guessCountForThisRound = 0
        
    }
    
    // User pressed return so make the the same as pressing the button
    @IBAction func inputGiven(_ sender: Any) {
        checkGuess(self)
    }
    
    // Keep track of guesses
    func updateGuessCount() {
        guessCountForThisRound += 1
        if guessCountForThisRound == 1 {
            guessTracker.text = "1 guess made."
        } else {
            guessTracker.text = "\(guessCountForThisRound) guesses made."
        }
    }
    
}

