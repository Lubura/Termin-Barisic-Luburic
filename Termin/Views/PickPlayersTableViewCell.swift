//
//  PickPlayersTableViewCell.swift
//  Termin
//
//  Created by Marko Barisic on 02/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

struct PickPlayersCellData {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
}

class PickPlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(with data: PickPlayersCellData) {
        self.playerLabel.text = data.name
    }
    
}
