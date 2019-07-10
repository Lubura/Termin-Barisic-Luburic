//
//  GameTableViewCell.swift
//  Termin
//
//  Created by FIVE on 10/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

struct GamesCellData{
    var date : String?
    var result : String?
    
    init(date : String, result: String){
        self.date = date
        self.result = result
    }
}

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(with data : GamesCellData){
        self.resultLabel.text = data.result
        self.dateLabel.text = data.date
    }
    
}
