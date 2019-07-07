//
//  SimulationViewController.swift
//  Termin
//
//  Created by Marko Barisic on 06/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit
import Foundation

class SimulationViewController: UIViewController {

    var viewModel: SimulationViewModel!
    var players: [Player]!
    var gameType: [String:Bool]!
    var scoreNum: Int!
    var hourNum: Int!
    var minuteNum: Int!
    
//    Atriburti za unos u bazu podataka
    var team1: [Player]!
    var team2: [Player]!
    var goalMinute: [Player:[Int]] = [:]
    var date = Date()
    var team1Result = 0
    var team2Result = 0
//    ----------------------------------
    
    var timer = Timer()
    var timeSecond: Int = 0
    var timeMinute: Int = 0
    var timeHour: Int = 0
    var timerPaused: Bool = true
    
    var gameEnded = false
    var gameStarted = false
    
    @IBOutlet weak var teamTable: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    convenience init(players: [Player], gameType: [String:Bool], scoreNum: Int, hourNum: Int, minuteNum: Int) {
        self.init()
        self.players = players
        self.gameType = gameType
        self.scoreNum = scoreNum
        self.hourNum = hourNum
        self.minuteNum = minuteNum
        self.team1 = []
        self.team2 = []
        makeTeams()
        self.viewModel = SimulationViewModel(players: self.players , team1: self.team1, team2: self.team2)
    }
    
//----------STVARANJE-EKIPA----------
    private func makeTeams(){
        var i = 0
        let range = 1...100
        while i < 2*(players.count/2){
            let randInt = (numericCast(arc4random_uniform(numericCast(range.count))) + range.lowerBound)%2
            if randInt == 0 {
                team1.append(players[i])
                team2.append(players[i+1])
            } else {
                team1.append(players[i+1])
                team2.append(players[i])
            }
            i += 2
        }
        
        if players.count % 2 == 1 {
            let randInt = (numericCast(arc4random_uniform(numericCast(range.count))) + range.lowerBound)%2
            if randInt == 0 {
                team1.append(players.last!)
            } else {
                team2.append(players.last!)
            }
        }
        players.sort { (player1, player2) -> Bool in
            if player1.name < player2.name {
                return true
            }
            return false
        }
        team1.sort { (player1, player2) -> Bool in
            if player1.name < player2.name {
                return true
            }
            return false
        }
        team2.sort { (player1, player2) -> Bool in
            if player1.name < player2.name {
                return true
            }
            return false
        }
    }
//-----------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "00:00:00"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "play25"), style: .plain, target: self, action: #selector(onTapStart))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onTapBack))
        setupTableView()
    }
    
    @objc func onTapBack() {
        if gameStarted == false {
            self.showAlert()
        }
        if gameEnded == false {
            onTapPause()
        }
        let alertController = UIAlertController(title: "Data will be lost!", message: "Are you sure you want to go back?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler:  { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: {[weak self] _ in
            if self?.gameEnded == false {
                self?.onTapStart()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Teams will be lost!", message: "Are you sure you want to go back?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler:  { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
//    ----------TIMER----------
    @objc func onTapStart(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(everySecond), userInfo: nil, repeats: true)
        gameStarted = true
        timerPaused = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pause25"), style: .plain, target: self, action: #selector(onTapPause))
    }
    
    @objc func onTapPause() {
        timer.invalidate()
        timerPaused = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "play25"), style: .plain, target: self, action: #selector(onTapStart))
    }
    
    @objc func everySecond(){
        timeSecond+=1
        if timeSecond == 60 {
            timeSecond = 0
            timeMinute+=1
            if timeMinute == 60 {
                timeMinute = 0
                timeHour+=1
            }
        }
        switch timeMinute {
        case 0...9:
            switch timeSecond {
            case 0...9:
                self.title = "0"+String(timeHour)+":0"+String(timeMinute)+":0"+String(timeSecond)
            default:
                self.title = "0"+String(timeHour)+":0"+String(timeMinute)+":"+String(timeSecond)
            }
        default:
            switch timeSecond {
            case 0...9:
                self.title = "0"+String(timeHour)+":"+String(timeMinute)+":0"+String(timeSecond)
            default:
                self.title = "0"+String(timeHour)+":"+String(timeMinute)+":"+String(timeSecond)
            }
        }
        if gameType["Time"] == true {
            if timeHour == hourNum, timeMinute == minuteNum {
                onTapStop()
            }
        }
    }
//    -------------------------
    
    @objc func onTapStop() {
        gameEnded = true
        timer.invalidate()
        timerPaused = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(endAndSave))
    }
    
    @objc func endAndSave() {
        if UserDefaults.standard.value(forKey: "gameId") == nil {
            UserDefaults.standard.set(1, forKey: "gameId")
        }
        let id = UserDefaults.standard.value(forKey: "gameId") as! Int
        let json: [String : Any] = ["id":id,
                                    "date":date as NSDate,
                                    "goalMinute":goalMinute,
                                    "team1":team1,
                                    "team2":team2,
                                    "team1Result":Int32(team1Result),
                                    "team2Result":Int32(team2Result)]
        
        for player in players {
            if goalMinute.index(forKey: player) != nil {
                print(DataController.shared.updatePlayerGoals(key: player.name, goals: goalMinute[player]!.count))
            } else {
                print(DataController.shared.updatePlayerGoals(key: player.name, goals: 0))
            }
        }

        for player in players {
            let playa = DataController.shared.searchPlayers(key: player.name)
            let playaer = playa!.first
            print("name-> \(String(describing: playaer?.name)) goals-> \(playaer?.goals) games-> \(String(describing: playaer?.games)) avgGoals-> \(String(describing: playaer?.avgGoals))")
        }
        
        UserDefaults.standard.set(id+1, forKey: "gameId")
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupTableView(){
        let nib = UINib.init(nibName: "SimulationTableViewCell", bundle: nil)
        teamTable.register(nib, forCellReuseIdentifier: "SimulationTableViewCell")
        teamTable.register(SimulationTableHeader.self, forHeaderFooterViewReuseIdentifier: SimulationTableHeader.reuseIdentifier)
        
        teamTable.delegate = self
        teamTable.dataSource = self
        
        teamTable.tableFooterView = UIView()
    }
}

extension SimulationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimulationTableViewCell", for: indexPath) as! SimulationTableViewCell
        if let simulationCellData = viewModel.simulationCellData(atIndexPath: indexPath) {
            cell.populate(with: simulationCellData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SimulationTableHeader.reuseIdentifier) as! SimulationTableHeader
        if let headerData = viewModel.simulationHeaderData(forSection: section) {
            header.populate(with: headerData)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if gameEnded == true || gameStarted == false || timerPaused == true{
            teamTable.deselectRow(at: indexPath, animated: false)
            return
        }
        teamTable.deselectRow(at: indexPath, animated: true)
        let player = viewModel.playerViewModel(forIndexPath: indexPath).player
        let cell = teamTable.cellForRow(at: indexPath) as! SimulationTableViewCell
        
        if goalMinute.index(forKey: player) == nil {
            goalMinute[player] = []
        }
        goalMinute[player]?.append(timeMinute)
        
        cell.goalsLabel.text = String(goalMinute[player]!.count)
        
        if team1.contains(player) {
            team1Result+=1
        } else if team2.contains(player) {
            team2Result+=1
        }
        
        scoreLabel.text = String(team1Result)+" - "+String(team2Result)
        
        if gameType["Score"] == true {
            if team1Result == scoreNum || team2Result == scoreNum {
                onTapStop()
            }
        }
    }
    
}
