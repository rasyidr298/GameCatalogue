//
//  File.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import Foundation

struct GamesResponse: Codable {
    var results: [Games?]
}

struct Games: Codable, Identifiable {
    var id = UUID()
    var idGames: Int?
    var name, released, backgroundImage : String?
    var rating: Float?

    enum CodingKeys: String, CodingKey {
        case name, rating, released
        case idGames = "id"
        case backgroundImage = "background_image"
    }
}
