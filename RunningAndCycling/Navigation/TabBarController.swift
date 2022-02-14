//
//  TabbarController.swift
//  RunningAndCycling
//
//  Created by lion on 3.02.22.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let iconFirstVC = UITabBarItem(title: "", image: UIImage(systemName: "list.bullet.rectangle"), selectedImage: UIImage(systemName: "list.bullet.rectangle"))
        mainVC.tabBarItem = iconFirstVC

        let runningVC = UINavigationController(rootViewController: RunningViewController())
        let iconSecondVC = UITabBarItem(title: "", image: UIImage(systemName: "figure.walk"), selectedImage: UIImage(systemName: "figure.walk"))
        runningVC.tabBarItem = iconSecondVC

        let cyclingVC = UINavigationController(rootViewController: CyclingViewController())
        let iconFourthVC = UITabBarItem(title: "", image: UIImage(systemName: "bicycle"), selectedImage: UIImage(systemName: "bicycle"))
        cyclingVC.tabBarItem = iconFourthVC

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let iconFifthVC = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        profileVC.tabBarItem = iconFifthVC

        
        let controllers = [mainVC, runningVC, cyclingVC, profileVC]
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
