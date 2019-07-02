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
    
//    var viewModel: PickPlayersViewModel
    
//    convenience init(viewModel: PickPlayersViewModel) {
//        self.init(viewModel: viewModel)
//        self.viewModel = viewModel
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Izaberi"
//        setupTableView()
//        bindViewModel()
    }

}
