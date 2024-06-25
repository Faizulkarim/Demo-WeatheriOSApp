//
//  SearchViewModel.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: SearchViewModel
final class SearchViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: SearchDisplayModel = SearchDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [SearchDisplayModel] {
        return models.map { SearchDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: SearchViewModelType

/// Get SearchViewModelType protocol methods
extension SearchViewModel: SearchViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: SearchViewModelInput) -> SearchViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> SearchViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return SearchViewModelOutput.init(viewState: viewDidLoadPublisher)
    }

}
