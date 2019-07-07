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
        
//        simulation
        let pickPlayersViewModel = PickPlayersViewModel()
        let pickPlayersVC = PickPlayersViewController(viewModel: pickPlayersViewModel)
        let simulationNavigationController = UINavigationController(rootViewController: pickPlayersVC)
        
        simulationNavigationController.navigationBar.tintColor = UIColor.white
        simulationNavigationController.navigationBar.barTintColor = UIColor.orange
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        simulationNavigationController.navigationBar.titleTextAttributes = textAttributes
        
        let simulationTabBarItem = UITabBarItem(title: "Play", image: UIImage(named: "stadion1"), tag: 0)
        simulationNavigationController.tabBarItem = simulationTabBarItem
        
        viewControllers = [simulationNavigationController]
        selectedIndex = 0
    }

}
