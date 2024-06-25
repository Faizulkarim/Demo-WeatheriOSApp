//
//  HomeDisplayModel.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

// MARK: HomeDisplayModel
struct HomeDisplayModel {
    var weatherData: WeatherForcastResponseModel?
    var currentLocation: CLLocationCoordinate2D?
}
