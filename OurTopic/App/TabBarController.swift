//
//  TabBarController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
        setupTabBarAppearance()
    }
    
    func configureTabBarController() {
        tabBar.delegate = self
        
        let firstVC = TopicViewController()
        let secondVC = SecondViewController()
        let thirdVC = SearchPhotoViewController()
        let fourthVC = FourthViewController()
        
        firstVC.tabBarItem.image = UIImage(systemName: "chart.xyaxis.line")
        secondVC.tabBarItem.image = UIImage(systemName: "play.rectangle")
        thirdVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        fourthVC.tabBarItem.image = UIImage(systemName: "heart")
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        let fourthNav = UINavigationController(rootViewController: fourthVC)
        
        setViewControllers([firstNav, secondNav, thirdNav, fourthNav], animated: true)
    }
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
}
