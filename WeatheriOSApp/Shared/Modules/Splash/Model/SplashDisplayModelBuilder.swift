//
//  SplashDisplayModelBuilder.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import Combine

// MARK: SplashDisplayModelBuilder
struct SplashDisplayModelBuilder {
    
    /// Transform the response model to display model
    ///
    /// - Parameters:
    ///   - model: Codable model.
    static func viewModel<T>(from model: T) -> SplashDisplayModel {
        return SplashDisplayModel()
    }
}
