//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation

extension OTDependencyManager {
    func splashBuilder() -> SplashBuildable {
        return SplashBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    func homeBuilder() -> HomeBuildable {
        return HomeBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    func topCityBuilder() -> TopCityBuildable {
        return TopCityBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    func searchBuilder() -> SearchBuildable {
        return SearchBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
}
