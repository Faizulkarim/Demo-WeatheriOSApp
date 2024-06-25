//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation


public enum APIEndpoint {
    
    case weather(params: Parameters)
    
    
}
extension APIEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return Constants.baseUrl
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .weather:
            return "weather/forecast"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .weather:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .weather(let params):
            print(params)
          return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self  {
        case .weather:
            return nil
        }
    }
    
}
