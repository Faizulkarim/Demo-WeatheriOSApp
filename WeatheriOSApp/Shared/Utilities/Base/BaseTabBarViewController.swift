//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
class BaseTabBarViewController: UITabBarController {
    
    let dependencyManager = OTDependencyManager.defaultValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarControllers()
        configureTabBarTheme()
    }
//
    func configureTabBarControllers() {
        let tabHome = dependencyManager.homeBuilder().build()
        let tabHomeItem = UITabBarItem(title: "Home",
                                      image: dependencyManager.theme().imageTheme.tabHomeIcon,
                                      selectedImage: dependencyManager.theme().imageTheme.tabHomeIcon)
        tabHome.tabBarItem = tabHomeItem

        let tabTopCity = dependencyManager.topCityBuilder().build()
        let tabTopCityItem = UITabBarItem(title: "Top City",
                                      image: dependencyManager.theme().imageTheme.tabTopCityIcon,
                                      selectedImage: dependencyManager.theme().imageTheme.tabTopCityIcon)
        tabTopCity.tabBarItem = tabTopCityItem

        self.viewControllers = [tabHome,tabTopCity]
    }

    func configureTabBarTheme() {
        tabBar.tintColor = dependencyManager.theme().colorTheme.colorPrimaryBlack
        tabBar.backgroundColor = dependencyManager.theme().colorTheme.colorPrimaryGray
    }
    
}

extension BaseTabBarViewController {
    
    static func createObj() -> BaseTabBarViewController  {
        let baseStoryBoard = UIStoryboard(name: "BaseStoryboard", bundle: Bundle.main)
        let baseTabBarViewController = baseStoryBoard.instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
        return baseTabBarViewController
    }
    
}
