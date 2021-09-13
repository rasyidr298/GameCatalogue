//
//  NetworkService.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//
import Foundation

var key = "0d26d24c6314431f97ce33207c57eb42"

enum Services: String {
    case service = ""
}

var baseURL: String {
    switch NetworkManager.networkEnviroment {
        case .dev: return "https://api.rawg.io/api/"
        case .production: return "https://api.rawg.io/api/"
        case .stage: return "https://api.rawg.io/api/"
    }
}

class NetworkService: NSObject {}
