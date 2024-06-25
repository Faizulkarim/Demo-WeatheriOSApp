//
//  TopCityBuilder.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: Module Builder
/// Builder class to build module
final class TopCityBuilder: TopCityBuildable {

    // MARK: Properties
    /// Dependency manager.
    let dependencyManager: DependencyManager

    // MARK: Init/Deinit
    /// Creates new instance with provided dependencies.
    ///
    /// - Parameters:
    ///   - dependencyManager: Dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }

    // MARK: Protocol conformance

    // MARK: TopCityBuildable
    func build() -> UIViewController {
        let viewModel = TopCityViewModel(apiManager: dependencyManager.apiManager())
        let view = buildView(viewModel: viewModel, router: buildRouter())
        return view
    }
    
    // MARK: Instance functions

    // MARK: Private Instance Functions
    private func buildView(viewModel: TopCityViewModel, router: TopCityRouter) -> TopCityViewController {
        let theme = dependencyManager.theme()
        let analyticsManager = dependencyManager.analyticsManager()

        let viewController = TopCityViewController(analyticsManager: analyticsManager,
                                                                     theme: theme,
                                                                     viewModel: viewModel,
                                                                     router: router)

        return viewController
    }

    private func buildRouter() -> TopCityRouter {
        return TopCityRouter(dependencyManager: self.dependencyManager)
    }
}
