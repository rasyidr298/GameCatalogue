//
//  NetworkService.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//
import Foundation

var apiKey: String {get {
    // 1
    guard let filePath = Bundle.main.path(forResource: "RAWG-Info", ofType: "plist") else {
        fatalError("Couldn't find file 'RAWG-Info.plist'.")
    }
    // 2
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
        fatalError("Couldn't find key 'API_KEY' in 'RAWG-Info.plist'.")
    }
    // 3
    if (value.starts(with: "_")) {
        fatalError("Register for a RAWG developer account and get an API key at...")
    }
    return value
}
}

enum Services: String {
    case service = ""
}

var baseURL: String {
    switch NetworkManager.networkEnviroment {
    case.dev: return "https://api.rawg.io/api/"
    case.production: return "https://api.rawg.io/api/"
    case.stage: return "https://api.rawg.io/api/"
    }
}

class NetworkService: NSObject {}
