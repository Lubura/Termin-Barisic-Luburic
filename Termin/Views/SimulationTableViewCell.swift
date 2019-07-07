//
//  SimulationTableViewCell.swift
//  Termin
//
//  Created by Marko Barisic on 06/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

struct SimulationCellData {
    var name: String?
    var goals: Int
    init(name: String?) {
        self.name = name
        self.goals = 0
    }
}

class SimulationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var goalsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(with data: SimulationCellData) {
        self.nameLabel.text = data.name
        self.goalsLabel.text = ""
    }
    
}
