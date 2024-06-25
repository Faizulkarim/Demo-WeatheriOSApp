//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
struct OTImageTheme: ImageTheme {
    var navBack: UIImage {
        return UIImage(systemName: "arrow.backward")!
    }

    var tabHomeIcon: UIImage {
        return UIImage(systemName: "cloud.sleet")!
    }
    
    var tabTopCityIcon: UIImage{
        return UIImage(systemName: "globe.asia.australia")!
    }
    
    var addButtonImage: UIImage {
        return UIImage(systemName: "plus")!
    }

    
}
