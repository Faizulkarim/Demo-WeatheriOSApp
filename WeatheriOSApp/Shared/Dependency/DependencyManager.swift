//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation
import UIKit

protocol DependencyManager: BuilderFactory, UtilityFactory {
    
    ///  Configured dependency manager for usage.
    /// - warning: Should be called before attempting to start or access dependencies.
    ///
    /// - Parameters:
    ///   - rootWindow: Root window of application.
    func configure(rootWindow: UIWindow?)
    

    
}
