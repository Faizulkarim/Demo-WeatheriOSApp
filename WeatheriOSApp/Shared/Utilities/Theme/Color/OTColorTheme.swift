//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct OTColorTheme: ColorTheme {
    var clearColor: UIColor {
        return .clear
    }
    var colorPrimaryWhite : UIColor? {
        return UIColor.init(named: "PrimaryWhite")
    }
    
    var colorPrimaryBlack : UIColor? {
        return UIColor.init(named: "PrimaryBlack")
    }
    var colorPrimaryGray: UIColor? {
        return UIColor.init(named: "PrimaryGray")
    }
    
}
