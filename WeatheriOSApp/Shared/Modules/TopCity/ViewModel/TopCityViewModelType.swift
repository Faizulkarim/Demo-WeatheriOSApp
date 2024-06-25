//
//  TopCityViewModelType.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: TopCityViewModelInput
struct TopCityViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let weatherForcastApiSubject : AnyPublisher <Parameters, Never>
}

// MARK: ViewModelOutput
struct TopCityViewModelOutput {
    let viewState: AnyPublisher<TopCityViewState, Never>
}

// MARK: ViewState
enum TopCityViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case weatherApiSuccess(response: WeatherForcastResponseModel?)
}

// MARK: TopCityViewModelType
protocol TopCityViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: TopCityViewModelInput) -> TopCityViewModelOutput
}
