//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation
import UIKit

class BaseNavigationViewController: UINavigationController {}

extension BaseNavigationViewController {
    
    static func createObj(with rootVC: UIViewController) -> BaseNavigationViewController  {
        let baseStoryBoard = UIStoryboard(name: "BaseStoryboard", bundle: Bundle.main)
        let baseNavigationViewController = baseStoryBoard.instantiateViewController(withIdentifier: "BaseNavigationViewController") as! BaseNavigationViewController
        baseNavigationViewController.viewControllers = [rootVC]
        return baseNavigationViewController
    }
    
}



