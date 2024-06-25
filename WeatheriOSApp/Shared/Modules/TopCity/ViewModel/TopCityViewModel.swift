//
//  TopCityViewModel.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: TopCityViewModel
final class TopCityViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: TopCityDisplayModel = TopCityDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [TopCityDisplayModel] {
        return models.map { TopCityDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: TopCityViewModelType

/// Get TopCityViewModelType protocol methods
extension TopCityViewModel: TopCityViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: TopCityViewModelInput) -> TopCityViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> TopCityViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()
        
        let weatherApiPublisher : PassthroughSubject <TopCityViewState, Never> = .init()
        input.weatherForcastApiSubject.flatMap { requestModel -> AnyPublisher<Result<WeatherForcastResponseModel?, OTError>, Never> in
            weatherApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.getWeatherForcast(requestModel)
        }.sink { result in
            DispatchQueue.main.async {
                weatherApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    weatherApiPublisher.send(.weatherApiSuccess(response: response))
                case .failure(let error):
                    weatherApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)
        
        let viewDidLoadAndLoadDataPublisher = Publishers.MergeMany(viewDidLoadPublisher,weatherApiPublisher.eraseToAnyPublisher()).eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return TopCityViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}
