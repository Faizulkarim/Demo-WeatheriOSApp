//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct OTFontTheme: FontTheme {
    var regularMontserrat: MontserratFonts = MontserratFonts.Regular
}

enum MontserratFonts: String {
    case Regular = "Montserrat-Regular"

    func font(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}
