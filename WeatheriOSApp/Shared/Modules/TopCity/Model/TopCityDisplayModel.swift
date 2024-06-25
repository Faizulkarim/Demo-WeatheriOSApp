//
//  TopCityDisplayModel.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation



// MARK: TopCityDisplayModel
struct TopCityDisplayModel {
    var topCity = [CLLocationCoordinate2D(latitude: 35.713995, longitude: 139.784765),CLLocationCoordinate2D(latitude: 40.712728, longitude: -74.006015)]
    var tempData: [TempData]?
}

struct TempData {
    let time: String
    let temp : Int
}

