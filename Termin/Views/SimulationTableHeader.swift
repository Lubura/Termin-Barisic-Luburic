//
//  SimulationTableHeader.swift
//  Termin
//
//  Created by Marko Barisic on 06/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation
import UIKit

struct SimulationHeaderData {
    var title: String
    var backgroundColor: UIColor
    
    init(title: String, backgroundColor: UIColor) {
        self.title = title
        self.backgroundColor = backgroundColor
    }
}

class SimulationTableHeader: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "SimulationTableHeader"
    let titleLabel = UILabel.init()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func populate(with data: SimulationHeaderData) {
        titleLabel.text = data.title
        contentView.backgroundColor = data.backgroundColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
