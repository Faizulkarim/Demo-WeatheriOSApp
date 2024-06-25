//
//  TopCityBuildable.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// TopCity builder protocol.
protocol TopCityBuildable {

    /// Builds the TopCity view.
    ///
    /// - Returns: TopCity details view.
    func build() -> UIViewController

}
