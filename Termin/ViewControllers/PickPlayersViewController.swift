//
//  PickPlayersViewController.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

class PickPlayersViewController: UIViewController {

    @IBOutlet weak var pickPlayersTable: UITableView!
    
    var viewModel: PickPlayersViewModel!
    var refreshControl: UIRefreshControl!
    var selectedPlayers: [Player] = []
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    convenience init(viewModel: PickPlayersViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pick"
        let importService = ImportDataService()
        importService.importPlayers()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "lopta1"), style: .plain, target: self, action: #selector(onTapGoToSimulation))
        setupTableView()
        bindViewModel()
    }
    
    @objc func onTapGoToSimulation() {
        if selectedPlayers.count < 1 {
            self.showAlert()
        }
        let simulationVC = SimulationOptionsViewController(players: selectedPlayers)
        self.navigationController?.pushViewController(simulationVC, animated: true)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Number of players", message: "You have to pick at least 10 players to play a game!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupTableView(){
        let nib = UINib.init(nibName: "PickPlayersTableViewCell", bundle: nil)
        pickPlayersTable.register(nib, forCellReuseIdentifier: "PickPlayersTableViewCell")
        
        pickPlayersTable.delegate = self
        pickPlayersTable.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PickPlayersViewController.refresh), for: .valueChanged)
        pickPlayersTable.refreshControl = refreshControl
        
        pickPlayersTable.tableFooterView = UIView()
        
        pickPlayersTable.backgroundView = activityIndicator
    }
    
    private func bindViewModel(){
        activityIndicator.startAnimating()
        viewModel.fetchPlayers { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.pickPlayersTable.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    func deselectAll() {
        let rows = self.tableView(pickPlayersTable, numberOfRowsInSection: 1)
        for i in 0...rows {
            let cell = pickPlayersTable.cellForRow(at: IndexPath(row: i, section: 1))
            cell?.backgroundColor = UIColor.clear
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.pickPlayersTable.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension PickPlayersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pickPlayersTable.dequeueReusableCell(withIdentifier: "PickPlayersTableViewCell", for: indexPath) as! PickPlayersTableViewCell
        if let pickPlayersCellData = viewModel.pickPlayersCellData(atIndexPath: indexPath) {
            cell.populate(with: pickPlayersCellData)
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
        pickPlayersTable.deselectRow(at: indexPath, animated: true)
        let player = viewModel.playerViewModel(forIndexPath: indexPath).player
        let cell = pickPlayersTable.cellForRow(at: indexPath)
        if selectedPlayers.contains(player){
            cell?.backgroundColor = UIColor.clear
            selectedPlayers.remove(at: (selectedPlayers.index(of: player))!)
        }
        else {
            selectedPlayers.append(player)
            cell?.backgroundColor = UIColor.green.withAlphaComponent(0.6)
        }
        selectedPlayers.sort { (player1, player2) -> Bool in
            if player1.rating > player2.rating {
                return true
            }
            return false
        }
    }
    
}
