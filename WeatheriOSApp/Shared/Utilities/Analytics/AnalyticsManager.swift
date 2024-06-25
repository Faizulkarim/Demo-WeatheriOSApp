//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

/// Analytics manager protocol.
public protocol AnalyticsManager {
    
    /// Starts the analytics manager.
    func start()
    
    /// Tracks viewing of the provided screen.
    ///
    /// - Parameter screen: Screen.
    func track(screenView screen: AnalyticsScreen)
    
}

/// DefaultAnalyticsManager.
struct DefaultAnalyticsManager: AnalyticsManager {
    func start() {
        
    }
    
    func track(screenView screen: AnalyticsScreen) {
        
    }
}
