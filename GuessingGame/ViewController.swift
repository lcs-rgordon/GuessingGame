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
    
    // MARK: Properties
    var targetNumber : Int = -1
    
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
        instructionsLabel.text = "You got it!"
        guessButton.isHidden = true
        playAgainButton.isHidden = false
    }
    
    // Start a new game
    @IBAction func startNewGame(_ sender: Any) {
        
        // Generate a number for the player to guess
        self.targetNumber = Int(arc4random_uniform(1001)) // Produce a number between 1 and 1000, inclusive (but not 1001)
        
        // Reset the interface
        playAgainButton.isHidden = true
        guessButton.isHidden = false
        instructionsLabel.text = "I'm thinking of a number\nbetween 0 and 1000.\n\nGuess it!"
        guessedNumber.text = ""
        
    }
    
    // User pressed return so make the the same as pressing the button
    @IBAction func inputGiven(_ sender: Any) {
        checkGuess(self)
    }
    
}

