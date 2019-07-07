//
//  SimulationOptionsViewController.swift
//  Termin
//
//  Created by Marko Barisic on 06/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

class SimulationOptionsViewController: UIViewController {

    var players: [Player]!
    var gameType: [String:Bool] = ["Score":false, "Time":false]
    var goals: Int = 10
    var hour: Int = 1
    var minute: Int = 0
    
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var scoreSlider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func scoreTapped(_ sender: UIButton) {
        if gameType["Score"] == false {
            scoreButton.tintColor = UIColor.white
            scoreButton.backgroundColor = UIColor.orange
            gameType["Score"] = true
        }
        else {
            scoreButton.tintColor = UIColor.orange
            scoreButton.backgroundColor = UIColor.clear
            gameType["Score"] = false
        }
    }
    @IBAction func scoreSliderMoved(_ sender: UISlider) {
        if sender != scoreSlider {
            return
        }
        goals = Int(sender.value)
        if goals == 1 {
            scoreLabel.text = String(goals)+" goal"
        } else{
            scoreLabel.text = String(goals)+" goals"
        }
    }
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBAction func timeSliderMoved(_ sender: UISlider) {
        if sender != timeSlider {
            return
        }
        minute = Int(sender.value)
        if minute >= 60 {
            if minute == 120 {
                hour = 2
                minute = 0
                timeLabel.text = String(hour)+" hours"
            } else {
                if minute == 60 {
                    hour = 1
                    minute = 0
                    timeLabel.text = String(hour)+" hour"
                } else {
                    hour = 1
                    minute = minute - 60
                    if minute == 1 {
                        timeLabel.text = String(hour)+" hour "+String(minute)+" minute"
                    } else {
                        timeLabel.text = String(hour)+" hour "+String(minute)+" minutes"
                    }
                }
            }
        } else {
            hour = 0
            if minute == 1 {
                timeLabel.text = String(minute)+" minute"
            } else {
                timeLabel.text = String(minute)+" minutes"
            }
        }
    }
    
    
    @IBAction func timeTapped(_ sender: UIButton) {
        if gameType["Time"] == false {
            timeButton.tintColor = UIColor.white
            timeButton.backgroundColor = UIColor.orange
            gameType["Time"] = true
        }
        else {
            timeButton.tintColor = UIColor.orange
            timeButton.backgroundColor = UIColor.clear
            gameType["Time"] = false
        }
    }
    
    
    @IBAction func playTapped(_ sender: UIButton) {
        if gameType == ["Score":false, "Time":false] {
            self.showAlert()
        }
        let simulationVC = SimulationViewController(players: players, gameType: gameType, scoreNum: goals, hourNum: hour, minuteNum: minute)
        
        self.navigationController?.pushViewController(simulationVC, animated: true)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Game type", message: "You have to pick Time or Score or both!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Options"
    }
    
    convenience init(players: [Player]){
        self.init()
        self.players = players
    }

}
