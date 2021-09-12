//
//  GameCatalogueApp.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

@main
struct GameCatalogueApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GamesViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
