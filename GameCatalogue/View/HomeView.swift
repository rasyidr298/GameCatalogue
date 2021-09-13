//
//  HomeView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var gameViewModel: GamesViewModel

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
            if gameViewModel.games.results.isEmpty {
                gameViewModel.getGames()
            }
        }
    }
}

struct ContentHomeView: View {

    @EnvironmentObject var gameViewModel: GamesViewModel
    @Namespace var topID
    @Namespace var bottomID

    var body: some View {
        ScrollView(.vertical) {

            ForEach(Array(gameViewModel.games.results.enumerated()), id: \.offset) {
                _, games in

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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(GamesViewModel())
    }
}
