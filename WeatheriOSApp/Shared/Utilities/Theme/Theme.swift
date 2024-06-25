//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation
protocol Theme {
    /// Color theme object.
    var colorTheme: ColorTheme { get set }
    
    /// Font theme object.
    var fontTheme: FontTheme { get set }
    var imageTheme: ImageTheme {get set}

   
}
