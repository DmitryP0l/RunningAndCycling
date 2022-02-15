//
//  TabbarController.swift
//  RunningAndCycling
//
//  Created by lion on 3.02.22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    private func setupTabBarItems() {
        let mainVC = configureTabBarItem(rootViewController: MainViewController(),
                                            image: UIImage(systemName: "list.bullet.rectangle"),
                                            selectedImage: UIImage(systemName: "list.bullet.rectangle"))
        let runningVC = configureTabBarItem(rootViewController: RunningViewController(),
                                            image: UIImage(systemName: "figure.walk"),
                                            selectedImage: UIImage(systemName: "figure.walk"))
        let cyclingVC = configureTabBarItem(rootViewController: CyclingViewController(),
                                            image: UIImage(systemName: "bicycle"),
                                            selectedImage: UIImage(systemName: "bicycle"))
        let profileVC = configureTabBarItem(rootViewController: ProfileViewController(),
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person"))
        
        let controllers = [mainVC, runningVC, cyclingVC, profileVC]
        self.viewControllers = controllers
    }
    
    private func configureTabBarItem(rootViewController: UIViewController,
                                     image: UIImage?,
                                     selectedImage: UIImage?) -> NavigationBarController {
        let controller = NavigationBarController(rootViewController: rootViewController)
        let controllerIcon = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        controller.tabBarItem = controllerIcon
        
        return controller
    }
}


