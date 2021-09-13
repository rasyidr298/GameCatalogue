//
//  File.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import Foundation

struct DetailGameResponse: Codable {
    var id: Int?
    var name, description, released, backgroundImage: String?
    var rating: Float?
    var platforms: [Platforms?]
    var genres: [Genre?]
    
    enum CodingKeys : String, CodingKey{
        case id, name, description, released, rating, platforms, genres
        case backgroundImage = "background_image"
    }
}

struct Platforms: Codable, Identifiable {
    var id = UUID()
    var platform: Platform?

    enum CodingKeys: CodingKey {
        case platform
    }
}

struct Platform: Codable {
    var name: String?
}

struct Genre: Codable, Identifiable {
    var id = UUID()
    var name: String?

    enum CodingKeys: CodingKey {
        case name
    }
}
