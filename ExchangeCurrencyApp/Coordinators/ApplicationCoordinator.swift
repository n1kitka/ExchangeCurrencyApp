//
//  ApplicationCoordinator.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    var window: UIWindow
    var tabBarController: UITabBarController
    var currencyRatesCoordinator: CurrencyRatesCoordinator

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
        self.currencyRatesCoordinator = CurrencyRatesCoordinator(tabBarController: tabBarController)
    }

    func start() {
        currencyRatesCoordinator.start()
        window.rootViewController = tabBarController
    }
    
}
