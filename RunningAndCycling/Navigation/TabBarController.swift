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
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let iconFirstVC = UITabBarItem(title: "", image: UIImage(systemName: "list.bullet.rectangle"), selectedImage: UIImage(systemName: "list.bullet.rectangle.fill"))
        mainViewController.tabBarItem = iconFirstVC

        let runningViewController = UINavigationController(rootViewController: RunningViewController())
        let iconSecondVC = UITabBarItem(title: "", image: UIImage(systemName: "clock"), selectedImage: UIImage(systemName: "clock.fill"))
        runningViewController.tabBarItem = iconSecondVC

        let cyclingViewController = UINavigationController(rootViewController: CyclingViewController())
        let iconFourthVC = UITabBarItem(title: "", image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"))
        cyclingViewController.tabBarItem = iconFourthVC

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let iconFifthVC = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        profileVC.tabBarItem = iconFifthVC

        
        let controllers = [mainViewController, runningViewController, cyclingViewController, profileVC]
        self.viewControllers = controllers
        
        // как "снимать" размеры tabbar item, чтобы не прописывать их руками?
        // как закрепить к tabbar item-у кастомную кнопку?
        //можно ли вообще прикрутить к tabbar item-у функционал вызова алертконтроллера, чтобы не заниматься всей этой фигней с "ширмой" в виде кнопки?
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
