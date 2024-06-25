//
//  SplashBuildable.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// Splash builder protocol.
protocol SplashBuildable {

    /// Builds the Splash view.
    ///
    /// - Returns: Splash details view.
    func build() -> UIViewController

}
