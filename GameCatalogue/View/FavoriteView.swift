//
//  FavoriteView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {

    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject var gameViewModel: GamesViewModel
    @Environment(\.managedObjectContext) var context

    var body: some View {
        NavigationView {
            VStack {
                Text("").onAppear{
                    favoriteViewModel.getAllFavorite(context: context)
                }
                ScrollView(.vertical) {
                    
                    ForEach(Array(favoriteViewModel.favorite.results.enumerated()), id: \.offset) {_, games in

                        FavoriteItemView(games: games!)
                            .contextMenu{
                                Button(action: {
                                    favoriteViewModel.deleteFavorite(context: context, idGame: (games?.idGames)!)
                                }, label: {
                                    Text("Delete")
                                })
                            }
                        
                    }
                }.sheet(isPresented: $favoriteViewModel.showModalFavorite, content: {
                    DetailView().environmentObject(gameViewModel).environmentObject(favoriteViewModel)
                })
            }.navigationTitle("Favorite")
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
