//
//  OneGameViewController.swift
//  Termin
//
//  Created by FIVE on 10/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

class OneGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTables()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var teamsTable: UITableView!
    @IBOutlet weak var goalMinuteTable: UITableView!
   
    @IBOutlet weak var gameResultLabel: UILabel!
    @IBOutlet weak var gameId: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let teamsResuseId = "PickPlayersTableViewCell"

    var gameViewModel: GameViewModel!
    var refreshControl : UIRefreshControl!
    
    
    convenience init(viewModel: GameViewModel){
        self.init()
        self.gameViewModel = viewModel
    }
    
    func setupTables(){
        
    }
    @objc func refresh(){
        DispatchQueue.main.async {
            self.teamsTable.reloadData()
           
            self.goalMinuteTable.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    

  
}
//extension OneGameViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == teamsTable{
//            return 2
//        }else if tableView == goalMinuteTable{
//            return 1
//        }
//    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == teamsTable {
//
//        }else if tableView == goalMinuteTable{
//
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseId, for: indexPath) as! QuizTableViewCell
//
//        if let quiz = self.quiz(indexPath) {
//            cell.setup(withQuiz: quiz)
//            return cell
//        }
//        return QuizTableViewCell()
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.sections?.count ?? 0
//    }
//
//
    
//}
