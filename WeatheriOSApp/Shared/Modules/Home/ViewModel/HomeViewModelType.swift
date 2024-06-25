//
//  HomeViewModelType.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: HomeViewModelInput
struct HomeViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let weatherForcastApiSubject : AnyPublisher <Parameters, Never>
}

// MARK: ViewModelOutput
struct HomeViewModelOutput {
    let viewState: AnyPublisher<HomeViewState, Never>
}

// MARK: ViewState
enum HomeViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case weatherApiSuccess(response: WeatherForcastResponseModel?)
}

// MARK: HomeViewModelType
protocol HomeViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput
}
