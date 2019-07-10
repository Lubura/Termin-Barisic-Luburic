//
//  GamesViewController.swift
//  Termin
//
//  Created by FIVE on 10/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    var gamesViewModel: AllGamesViewModel!
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var allGamesTable: UITableView!
    
    convenience init(viewModel: AllGamesViewModel){
        self.init()
        self.gamesViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        bindViewModel()
        
        
    }
    
    func setupTable(){
        allGamesTable.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        
        allGamesTable.delegate = self
        allGamesTable.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.refresh), for: .valueChanged)
        allGamesTable.refreshControl = refreshControl
        
        
    }

    private func bindViewModel(){
        
        gamesViewModel.fetchGames{ [weak self] in
            DispatchQueue.main.async {
                self?.allGamesTable.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.allGamesTable.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

}
extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allGamesTable.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        if let gamesCellData = gamesViewModel.gamesCellData(atIndexPath: indexPath) {
            cell.populate(with: gamesCellData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allGamesTable.deselectRow(at: indexPath, animated: true)
     
    }
    
}
