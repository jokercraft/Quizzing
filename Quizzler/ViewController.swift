//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestion = QuestionBank().list
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: " + String(score)
        progressLabel.text = "\(questionNumber+1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = String(allQuestion[questionNumber].questionText)
            updateUI()
        }else {
            let alert = UIAlertController(title: "Congrats", message: "Your score is \(score)", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            
            alert.addAction(restart)
            
            present(alert,animated: true,completion: nil)
        }
    }
    
    
    func checkAnswer() {
        if allQuestion[questionNumber].answer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
       questionNumber = 0
        score = 0
       nextQuestion()
    }
    

    
}
