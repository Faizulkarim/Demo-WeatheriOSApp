//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation
protocol UtilityFactory {
    func launchSequencer() -> LaunchSequencer
    func analyticsManager() -> AnalyticsManager
    func apiManager() -> OTAPIManager
    func theme() -> Theme
}
