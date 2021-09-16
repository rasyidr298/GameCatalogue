//
//  HomeView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject var gameViewModel: GamesViewModel
    @Environment(\.managedObjectContext) var context

    var body: some View {
        NavigationView {

            if gameViewModel.games.results.isEmpty {

                if gameViewModel.noInternet {
                    AnyView(ReconectView(message: "No Internet Connection..", action: {gameViewModel.getGames()}))
                } else if gameViewModel.isLoading {
                    AnyView(LoadingAnim())
                } else {
                    ContentHomeView()
                        .navigationBarTitle("Game")
                }
            } else {
                ContentHomeView()
                    .navigationBarTitle("Game")
            }

        }
        .onAppear {
            favoriteViewModel.getAllFavorite(context: context)
            if gameViewModel.games.results.isEmpty {
                gameViewModel.getGames()
            }
        }
    }
}

struct ContentHomeView: View {

    @EnvironmentObject var gameViewModel: GamesViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @Namespace var topID
    @Namespace var bottomID

    var body: some View {
        ScrollView(.vertical) {

            ForEach(Array(gameViewModel.games.results.enumerated()), id: \.offset) {_, games in

                ContentItemView(games: games!)
            }

            Button(action: {
                gameViewModel.page += 1
                gameViewModel.getGames()
            }, label: {
                if gameViewModel.isLoading {
                    Indicator()
                } else {
                    VStack {
                        Text("Next Page..").font(.caption)
                        Image(systemName: "arrowtriangle.down.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }

            }).padding(.bottom, 40)
        }.sheet(isPresented: $gameViewModel.showModalGames, content: {
            DetailView().environmentObject(gameViewModel).environmentObject(favoriteViewModel)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
