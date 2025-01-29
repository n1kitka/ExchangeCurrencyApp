//
//  CurrencyRatesCoordinator.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import UIKit

class CurrencyRatesCoordinator: Coordinator {
    var tabBarController: UITabBarController
    let viewModel = CurrencyViewModel()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let homeVC = CurrencyRatesViewController()
        homeVC.viewModel = viewModel
        
        let favoritesVC = FavoritesCurrenciesViewController()
        favoritesVC.viewModel = viewModel
        
        let homeNav = createNav(with: "Home", image: UIImage(systemName: "house"), vc: homeVC)
        let favoritesNav = createNav(with: "Favorites", image: UIImage(systemName: "star.fill"), vc: favoritesVC)
        
        tabBarController.setViewControllers([homeNav, favoritesNav], animated: true)
    }

    private func createNav(with title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
