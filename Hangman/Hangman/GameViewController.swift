//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var rightSentence: UILabel!
    @IBOutlet weak var wrong: UILabel!

    @IBOutlet weak var guessField: GuessField!
    var gameStateDone = false
    var haveWord = false
    var counter = 0
    var correctGuesses = Set<String>()
    var incorrectGuesses = Set<String>()
    var tracker = Set<String>()
    let num = 0
    var contains = false
    var phrase = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        setFirstPhrase(inputPhrase: phrase)
        for i in (phrase.characters) {
            correctGuesses.insert(String(i))
        }
        correctGuesses.remove(" ")
        placeHangmanImage(name: "hangman1.gif")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func restart(_ sender: AnyObject) { //restart the game instance
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        setFirstPhrase(inputPhrase: phrase)
        placeHangmanImage(name: "hangman1.gif")
        correctGuesses = Set<String>()
        counter = 0
        gameStateDone = false
        tracker = Set<String>()
        incorrectGuesses = Set<String>()
        for i in (phrase.characters) {
            correctGuesses.insert(String(i))
        }
        correctGuesses.remove(" ")
        wrong.text = "None wrong"
    }
    
    @IBAction func buttonGuess(_ sender: AnyObject) {
        let guessConst = guessField.text
        analyzeGuess(inputPhrase: phrase, guess: guessConst!)
        var incorrectString = ""
        for i in incorrectGuesses {
            incorrectString += " " + i
        }
        wrong.text = incorrectString //wrong answers counted
        
    }
    
    func analyzeGuess(inputPhrase: String, guess: String) {
        if gameStateDone == false {
            var spaceCount = ""
            contains = false
            for i in inputPhrase.characters {
                if String(i) == " " {
                    spaceCount += "   "
                } else if String(i) == guess {
                    contains = true
                    spaceCount += String(i)
                    correctGuesses.remove(String(i))
                    tracker.insert(String(i))
                    if correctGuesses.count == 0 {
                        gameStateDone = true
                        let alertController = UIAlertController(title: "Awesome job", message:"You just won! Wanna play again?", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default,handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    if tracker.contains(String(i)) {
                        spaceCount += String(i)
                    } else {
                        spaceCount += "_ "
                    }
                    
                }
            }
            
            if contains == false {
                incorrectGuesses.insert(String(guess))
                counter += 1
                if counter > 6 {
                    gameStateDone = true
                    let alertController = UIAlertController(title: "Sorry you lost the game", message:"Want to restart?", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let name = "hangman" + String(counter + 1) + ".gif"
                    placeHangmanImage(name: name)
                }
            }
            
            rightSentence.text = spaceCount //need to set the label to all of the counted spaces and _s
        }
        
    }
    
    func placeHangmanImage(name : String) { //set the image up front and thereafter
        gameImage.image = UIImage(named: name)!
    }
    
    func setFirstPhrase(inputPhrase: String) { //set the first instance of the game
        var spaceCount = ""
        for i in inputPhrase.characters {
            if String(i) == " " {
                spaceCount += "   "
            } else {
                spaceCount += "_ "
            }
            
        }
        rightSentence.text = spaceCount
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
