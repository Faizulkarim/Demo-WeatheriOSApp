//
//  SearchViewModelType.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: SearchViewModelInput
struct SearchViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct SearchViewModelOutput {
    let viewState: AnyPublisher<SearchViewState, Never>
}

// MARK: ViewState
enum SearchViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
}

// MARK: SearchViewModelType
protocol SearchViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: SearchViewModelInput) -> SearchViewModelOutput
}
