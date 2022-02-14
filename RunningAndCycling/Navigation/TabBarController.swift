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
    //    delegate = self
        setupTabBarItems()
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    private func setupTabBarItems() {
        let mainVC = configureTabBarItem(rootViewController: MainViewController(), tag: 0,
                                            image: UIImage(systemName: "list.bullet.rectangle"),
                                            selectedImage: UIImage(systemName: "list.bullet.rectangle"))
        let runningVC = configureTabBarItem(rootViewController: RunningViewController(), tag: 1,
                                            image: UIImage(systemName: "figure.walk"),
                                            selectedImage: UIImage(systemName: "figure.walk"))
        let cyclingVC = configureTabBarItem(rootViewController: CyclingViewController(), tag: 2,
                                            image: UIImage(systemName: "bicycle"),
                                            selectedImage: UIImage(systemName: "bicycle"))
        let profileVC = configureTabBarItem(rootViewController: ProfileViewController(), tag: 3,
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person"))
        
        let controllers = [mainVC, runningVC, cyclingVC, profileVC]
        self.viewControllers = controllers
    }
    
    private func configureTabBarItem(rootViewController: UIViewController,
                                     tag: Int,
                                     image: UIImage?,
                                     selectedImage: UIImage?) -> NavigationBarController {
        let controller = NavigationBarController(rootViewController: rootViewController)
        let controllerIcon = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        controller.tabBarItem = controllerIcon
        controller.tabBarItem.tag = tag
        
        return controller
    }
}
// можем отслеживать нажатия по тегу контроллера
//MARK: - UITabBarControllerDelegate
//extension TabBarController: UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//
//            if viewController.tabBarItem.tag == 2 {
//                selectedIndex = 0
//                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .CreateTask, object: nil)
//                }
//                return false
//            }
//            return true
//        }
//}
