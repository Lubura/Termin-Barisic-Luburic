//
//  TabBarViewController.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = UIColor.gray
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.orange
        tabBar.unselectedItemTintColor = .white
        
        let pokreniVC = PokreniViewController()
        let pokreniTabBarItem = UITabBarItem(title: "pokreni", image: UIImage(named: "stadion1"), tag: 0)
        pokreniVC.tabBarItem = pokreniTabBarItem
        
        viewControllers = [pokreniVC]
        selectedIndex = 0
    }

}
