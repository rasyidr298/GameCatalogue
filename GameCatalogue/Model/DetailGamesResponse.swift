//
//  File.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import Foundation

struct DetailGameResponse : Codable {
    var id : Int? = 0
    var name : String? = ""
    var description: String? = ""
    var released : String? = ""
    var background_image : String? = ""
    var rating : Float? = 0.0
    var metacritic: Int32? = -1
    var playtime : Int? = 0
    var platforms: [Platform]
    var genres: [Genre]
    
    struct Platform : Codable, Identifiable {
        var id = UUID()
        var name : String? = ""
        
        enum CodingKeys : CodingKey {
            case name
        }
    }
    
    struct Genre : Codable, Identifiable {
        var id = UUID()
        var name : String? = ""
        
        enum CodingKeys : CodingKey {
            case name
        }
    }
    
}
