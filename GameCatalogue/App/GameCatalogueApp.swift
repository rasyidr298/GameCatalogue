//
//  GameCatalogueApp.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

@main
struct GameCatalogueApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GamesViewModel())
        }
    }
}
