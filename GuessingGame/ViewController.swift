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
    
    // MARK: Properties
    let targetNumber = Int(arc4random_uniform(1001)) // Produce a number between 1 and 1000, inclusive (but not 1001)
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            instructionsLabel.text = "You got it!"
        } else if guess > targetNumber {
            instructionsLabel.text = "Guess lower."
        } else {
            instructionsLabel.text = "Guess higher."
        }
        
    }
    
}

