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
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(getQuestionLength())"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(getQuestionLength())) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        if questionNumber < getQuestionLength() {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            // Finish
            let alert = UIAlertController(title: "Awesome", message: "Do you want to restart the questions?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == correctAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
            score += 0
        }
    }
    
    func startOver() {
       questionNumber = 0
       score = 0
       nextQuestion()
    }
    
    func getQuestionLength() -> Int {
        return allQuestions.list.count
    }
}
