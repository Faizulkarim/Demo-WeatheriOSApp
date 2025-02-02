//
//  HomeBuildable.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// Home builder protocol.
protocol HomeBuildable {

    /// Builds the Home view.
    ///
    /// - Returns: Home details view.
    func build() -> UIViewController

}
