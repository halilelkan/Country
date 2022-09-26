//
//  MainTabbarViewController.swift
//  Countries
//
//  Created by halil ibrahim Elkan on 24.09.2022.
//

import UIKit
import CoreMedia

class MainTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        
        let item1 = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeNavigaitonVC")
        let icon1 = UITabBarItem(title: "Home", image:UIImage(named: "Home"), selectedImage: UIImage(named: "Home"))
        item1.tabBarItem = icon1
        
        let item2 = UIStoryboard.init(name: "Saved", bundle: Bundle.main).instantiateViewController(withIdentifier: "SavedNavigationVC")
        let icon2 = UITabBarItem(title: "Saved", image:UIImage(named: "Saved"), selectedImage: UIImage(named: "Saved"))
        item2.tabBarItem = icon2
        
        let controllers = [item1, item2]
        self.viewControllers = controllers
    }
}
