//
//  SearchBuildable.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// Search builder protocol.
protocol SearchBuildable {

    /// Builds the Search view.
    ///
    /// - Returns: Search details view.
    func build() -> UIViewController

}
