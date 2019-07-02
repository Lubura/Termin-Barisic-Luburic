//
//  PokreniViewController.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

class PokreniViewController: UIViewController {

   
    @IBOutlet weak var alertLabel: UILabel!
    @IBAction func pokreniButtonTapped(_ sender: Any) {
        alertLabel.text = "Niste odabrali dovoljan broj igrača"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Pokreni"
    }

}
