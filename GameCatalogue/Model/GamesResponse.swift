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
    var idGames = UUID()
    var id: Int?
    var name, released, backgroundImage : String?
    var rating: Float?

    enum CodingKeys: String, CodingKey {
        case id, name, rating, released
        case backgroundImage = "background_image"
    }
}
