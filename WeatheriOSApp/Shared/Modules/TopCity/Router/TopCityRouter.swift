//
//  TopCityRouter.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

/// TopCityRouter list router. Responsible for navigating from the view.
final class TopCityRouter {
    /// The navigation controller to use for navigation.
    weak var navigationController: UINavigationController?
    
    /// View controller used to present other views.
    weak var viewController: UIViewController?
    private let dependencyManager: DependencyManager
    
    /// Initializes the view router.
    ///
    /// - Parameter dependencyManager: The app dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }
    
    // MARK: - Instance functions
    
    /*
    /// Example method to implement for route.
    ///
    func routeToView() {}
    */
    
    func routeToSearch(){
        if let search = dependencyManager.searchBuilder().build() as? SearchViewController {
            search.delegate = self.viewController as! TopCityViewController
            let nc =  UINavigationController(rootViewController:search)
            nc.modalPresentationStyle = .overFullScreen
            nc.isNavigationBarHidden = true
            self.navigationController?.present(nc, animated: true)
        }
    }

}
