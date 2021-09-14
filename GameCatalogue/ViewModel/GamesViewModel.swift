//
//  GamesViewModel.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import Foundation
import Alamofire
import Combine
import CoreData

class GamesViewModel: ObservableObject {
    
    var page: Int = 2
    
    @Published var isLoading = false
    @Published var noInternet = false
    
    @Published var isLoadingSearch = false
    @Published var noInternetSearch = false
    
    @Published var itemClickId: Int = 0
    
    var didChange = ObservableObjectPublisher()
    
    @Published var games = GamesResponse(results: []) {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var detailGames = DetailGameResponse(platforms: [], genres: []) {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var searchGame = GamesResponse(results: []) {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var showModalGames: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getGames() {
        
        let url: String = "games?key=\(apiKey)&page=\(page)"
        
        if !Connectivity.isConnectedToInternet() {
            
            self.noInternet = true
            
        } else {
            self.isLoading = true
            
            NetworkManager(data: [:], headers: [:], url: url, service: nil, method: .get, isJSONRequest: false).executeQuery {(result: Result<GamesResponse, Error>) in
                
                switch result {
                
                case.success(let response) :
                    
                    print("succes get games : \(response.results.count)")
                    
                    DispatchQueue.main.async {
                        self.games.results.append(contentsOf: response.results)
                    }
                    
                case.failure(let error) :
                    
                    print("error get games : \(error)")
                }
                
                self.isLoading = false
                self.noInternet = false
            }
        }
    }
    
    func detailGames(idGames: Int) {
        let url = "games/\(idGames)?key=\(apiKey)"
        
        if !Connectivity.isConnectedToInternet() {
            
            self.noInternet = true
            
        } else {
            self.isLoading = true
            
            NetworkManager(data: [:], headers: [:], url: url, service: nil, method: .get, isJSONRequest: false).executeQuery {(result: Result<DetailGameResponse, Error>) in
                
                switch result {
                
                case .success(let response) :
                    
                    print("succes detail game : \(response.name ?? "")")
                    
                    DispatchQueue.main.async {
                        self.detailGames = response
                    }
                    
                case .failure(let error) :
                    
                    print("error detail game : \(error)")
                    
                }
                
                self.isLoading = false
                self.noInternet = false
            }
        }
    }
    
    func searchGame(query: String) {
        
        searchGame.results.removeAll()
        
        let url = "games?search=\(query)&key=\(apiKey)"
        
        if !Connectivity.isConnectedToInternet() {
            
            self.noInternetSearch = true
            
        } else {
            self.isLoadingSearch = true
            
            NetworkManager(data: [:], headers: [:], url: url, service: nil, method: .get, isJSONRequest: false).executeQuery {(result: Result<GamesResponse, Error>) in
                
                switch result {
                
                case .success(let response) :
                    
                    print("succes search game : \(response.results.count)")
                    
                    DispatchQueue.main.async {
                        self.searchGame = response
                    }
                    
                case.failure(let error) :
                    
                    print("error search game : \(error)")
                    
                }
                
                self.isLoadingSearch = false
                self.noInternetSearch = false
                
            }
        }
        
    }
}
