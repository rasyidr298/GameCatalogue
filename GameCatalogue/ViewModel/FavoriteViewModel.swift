//
//  FavoriteViewModel.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 13/9/21.
//

import Foundation
import CoreData
import Combine

class FavoriteViewModel: ObservableObject {
    
    var didChange = ObservableObjectPublisher()
    
    @Published var favorite = GamesResponse(results: []) {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var showModalFavorite: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var isFav: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func checkIdLocal(idGames: Int) {
        print("checkId : \(idGames)")
        isFav = favorite.results.contains(where: {$0?.idGames == idGames })
    }
    
    func addFavorite(context: NSManagedObjectContext,_ input: DetailGameResponse) {
        context.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Game", in: context) {
                let game = NSManagedObject(entity: entity, insertInto: context)
                game.setValue(input.idGames, forKey: "idGames")
                game.setValue(input.name, forKey: "name")
                game.setValue(input.description, forKey: "descriptionGame")
                game.setValue(input.backgroundImage, forKey: "backgroundImage")
                game.setValue(input.released, forKey: "released")
                game.setValue(input.rating, forKey: "rating")
                game.setValue(input.platforms.description, forKey: "platforms")
                game.setValue(input.genres.description, forKey: "genres")
                game.setValue(Date(), forKey: "addedGame")
                do {
                    try context.save()
                    getAllFavorite(context: context)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            
        }
    }
    
    func getAllFavorite(context: NSManagedObjectContext) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addedGame", ascending: false)]
            do {
                let results = try context.fetch(fetchRequest)
                var games: [Games] = []
                for result in results {
                    let game = Games(
                        idGames: result.value(forKeyPath: "idGames") as? Int,
                        name: result.value(forKeyPath: "name") as? String,
                        released: result.value(forKeyPath: "released") as? String,
                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                        rating: result.value(forKeyPath: "rating") as? Float
                    )
                    games.append(game)
                }
                self.favorite.results.removeAll()
                DispatchQueue.main.async {
                    self.favorite.results.append(contentsOf: games)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteFavorite(context: NSManagedObjectContext, idGame: Int) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "idGames == \(idGame)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    self.getAllFavorite(context: context)
                }
            }
        }
    }
}
