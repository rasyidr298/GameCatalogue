//
//  FavoriteView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var gameViewModel : GamesViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Game.entity(), sortDescriptors: [NSSortDescriptor(key: "addedGame", ascending :false)], animation: .spring()) var result : FetchedResults<Game>
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical){
                    ForEach(Array(result.enumerated()), id:\.offset){
                        offset, games in
                        
                        FavoriteItemView(games: games)
                            .contextMenu{
                                
                                Button(action: {
                                    context.delete(games)
                                    try! context.save()
                                }, label: {
                                    Text("Delete")
                                })
                                
                            }
                    }
                }
            }.navigationTitle("Favorite")
        }
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
