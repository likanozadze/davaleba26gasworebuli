//
//  TabBarController.swift
//  Davaleba26
//
//  Created by Lika Nozadze on 11/27/23.
//
// TabBarController.swift

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    // MARK: - Tab Setup
    
    private func setupTabs() {
        let Fact = self.createNav(with: "Fact", and: UIImage(systemName: "sailboat"), ViewController: CatFactViewController())
        let Breed = self.createNav(with: "Breed", and: UIImage(systemName: "clock"), ViewController: BreedCatFactViewController())
        
        self.setViewControllers([Fact, Breed], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, ViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: ViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}









