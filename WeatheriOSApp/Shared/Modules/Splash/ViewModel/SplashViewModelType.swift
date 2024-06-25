//
//  SplashViewModelType.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation
import Combine

// MARK: SplashViewModelInput
struct SplashViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>

    /// called when Splash wants to load data
    let loadDataSubject: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct SplashViewModelOutput {
    let viewState: AnyPublisher<SplashViewState, Never>
}

// MARK: ViewState
enum SplashViewState {
    /// Called when request is loading
    case loading
    
    /// Called when request is available
    case success(SplashDisplayModel?)
    
    /// Called when request is not available
    case noResults
    
    /// Called when request failed
    case failure(Error)
}

// MARK: SplashViewModelType
protocol SplashViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: SplashViewModelInput) -> SplashViewModelOutput
}

