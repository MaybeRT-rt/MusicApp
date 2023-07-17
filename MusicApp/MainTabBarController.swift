//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Liz-Mary on 17.07.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        UITabBar.appearance().backgroundColor = .white
        tabBar.tintColor = .systemIndigo
        creatTabBarControllers()
    }
    
    private func creatTabBarControllers() {
        viewControllers = [generateViewController(rootViewController: SearchViewController(), image: UIImage(systemName: "magnifyingglass") ?? UIImage(), title: "Search"), generateViewController(rootViewController: LibraryViewController(), image: UIImage(systemName: "music.note.list") ?? UIImage(), title: "Library")]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
}
