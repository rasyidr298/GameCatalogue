//
//  GamesViewModel.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import Foundation
import Alamofire
import Combine

class GamesViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var noInternet = false
    
    var didChange = ObservableObjectPublisher()
    
    @Published var games = GamesResponse(results: []){
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var detailGames = DetailGameResponse(platforms: [], genres: []){
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var searchGame = GamesResponse(results: []){
        didSet {
            objectWillChange.send()
        }
    }
    
    
    func getGames(){
        
        let url : String = "games?key=\(key)"
        
        if !Connectivity.isConnectedToInternet(){
            
            self.noInternet = true
            
        }else{
            self.isLoading = true
            
            NetworkManager(data: [:], headers: [:], url: url, service: nil, method: .get, isJSONRequest: false).executeQuery {
                (result: Result<GamesResponse, Error>) in
                
                self.isLoading = false
                self.noInternet = false
                
                switch result{
                
                case.success(let response) :
                    
                    print("succes get games : \(response.results.count)")
                    
                    DispatchQueue.main.async {
                        self.games = response
                    }
                    
                case.failure(let error) :
                    
                    print("error get games : \(error)")
                }
            }
        }
    }
    
    func detailGames(id : Int){
        let url = "games/\(id)?key=\(key)"
        
        if !Connectivity.isConnectedToInternet(){
            
            self.noInternet = false
            
        }else{
            self.isLoading = true
            
            NetworkManager(data: [:], headers: [:], url: url, service: nil, method: .get, isJSONRequest: false).executeQuery{
                (result : Result<DetailGameResponse, Error>) in
                
                self.isLoading = false
                self.noInternet = false
                
                switch result{
                
                case .success(let response) :
                    
                    print("succes detail game : \(response.name ?? "")")
                    
                    DispatchQueue.main.async {
                        self.detailGames = response
                    }
                    
                case .failure(let error) :
                    
                    print("error detail game : \(error)")
                    
                }
            }
        }
    }
    
    func searchGame(query : String){
        
        let url = "games?search=\(query)&key=\(key)"
        
        if !Connectivity.isConnectedToInternet(){
            
            self.noInternet = false
            
        }else{
            self.isLoading = true
            
            NetworkManager(data: [:], headers: [:], url: url, service: nil, method: .get, isJSONRequest: false).executeQuery{
                (result : Result<GamesResponse, Error>) in
                
                self.isLoading = false
                self.noInternet = false
                
                switch result{
                
                case .success(let response) :
                    
                    print("succes search game : \(response.results.count)")
                    
                    DispatchQueue.main.async {
                        self.searchGame = response
                    }
                    
                case.failure(let error) :
                    
                    print("error search game : \(error)")
                    
                }
            }
        }
        
    }
}
