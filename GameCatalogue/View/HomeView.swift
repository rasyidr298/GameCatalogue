//
//  HomeView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var gameViewModel : GamesViewModel
    
    var body: some View {
        NavigationView{
            
            if gameViewModel.games.results.isEmpty{
                
                if gameViewModel.noInternet{
                    AnyView(ReconectView(message : "No Internet Connection..", action: {gameViewModel.getGames()}))
                }else if gameViewModel.isLoading{
                    AnyView(LoadingAnim())
                }else{
                    ContentHomeView()
                        .navigationBarTitle("Game")
                }
            }else{
                ContentHomeView()
                    .navigationBarTitle("Game")
            }
            
        }
        .onAppear{
            if gameViewModel.games.results.isEmpty{
                gameViewModel.getGames()
            }
        }
    }
}

struct ContentHomeView : View {
    
    @EnvironmentObject var gameViewModel : GamesViewModel
    
    var body: some View{
        ScrollView(.vertical){
            ForEach(Array(gameViewModel.games.results.enumerated()), id:\.offset){
                offset, games in
                
                ContentItemView(games: games)
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(GamesViewModel())
    }
}
