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
                        .navigationBarTitle("", displayMode: .inline)
                }
            }
            
        }
        .onAppear{
            if gameViewModel.games.results.isEmpty{
                gameViewModel.getGames()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentHomeView : View {
    
    @EnvironmentObject var gameViewModel : GamesViewModel
    @State var showModal = false
    @State var searchText = ""
    
    var body: some View{
        
        ItemView()
            .onTapGesture {self.showModal.toggle()}
            .sheet(isPresented: $showModal, content: {
                DetailView().environmentObject(GamesViewModel())
            })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(GamesViewModel())
    }
}
