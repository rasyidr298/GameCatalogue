//
//  File.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import Foundation

struct GamesResponse : Codable {
    var results : [Games]
}

struct Games: Codable, Identifiable {
    var idGames = UUID()
    var id: Int? = 0
    var name: String? = ""
    var released: String? = ""
    var background_image: String? = ""
    
    enum CodingKeys: CodingKey {
        case id, name, released, background_image
    }
}

