//
//  SearchBuilder.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: Module Builder
/// Builder class to build module
final class SearchBuilder: SearchBuildable {

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

    // MARK: SearchBuildable
    func build() -> UIViewController {
        let viewModel = SearchViewModel(apiManager: dependencyManager.apiManager())
        let view = buildView(viewModel: viewModel, router: buildRouter())
        return view
    }
    
    // MARK: Instance functions

    // MARK: Private Instance Functions
    private func buildView(viewModel: SearchViewModel, router: SearchRouter) -> SearchViewController {
        let theme = dependencyManager.theme()
        let analyticsManager = dependencyManager.analyticsManager()

        let viewController = SearchViewController(analyticsManager: analyticsManager,
                                                                     theme: theme,
                                                                     viewModel: viewModel,
                                                                     router: router)

        return viewController
    }

    private func buildRouter() -> SearchRouter {
        return SearchRouter(dependencyManager: self.dependencyManager)
    }
}
