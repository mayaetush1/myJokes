//
//  RequestProtocol.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//
//

import Foundation

struct APIConfiguration {
    
    lazy var environment: AppEnvironment = {
        
        // read value from environment variable
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        
        if env == "TEST" {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
        
    }()
    
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: String {
        switch self {
            case .dev:
                return  "v2.jokeapi.dev"
            case .test:
                return  "v2.jokeapi.dev"
        }
    }
    
}
