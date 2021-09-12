//
//  SearchView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 11/9/21.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var gameViewModel : GamesViewModel
    @State var searchText = ""
    
    var body: some View {
        NavigationView{
            
            if gameViewModel.noInternetSearch{
                ReconectView(message: "No internet Connection..") {
                    gameViewModel.searchGame(query: searchText)
                }
            }else{
                if gameViewModel.isLoadingSearch{
                    Indicator()
                }else{
                    ContentSearchView(searchText: $searchText).navigationBarTitle("Search")
                }
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentSearchView : View {
    
    @EnvironmentObject var gameViewModel : GamesViewModel
    @State var showModal = false
    @Binding var searchText : String
    @State var inputSearch : String = ""
    @State var disableTextField : Bool = false
    
    var body: some View{
        ScrollView(.vertical){
            VStack{
                HStack {
                    
                    Image(systemName: "magnifyingglass").foregroundColor(Color("gray"))
                    TextField("Search", text: $inputSearch, onEditingChanged: { textChange in
                        if textChange{}else{gameViewModel.searchGame(query: searchText)}
                    }, onCommit: {
                        self.searchText = inputSearch
                    })
                    .disabled(disableTextField)
                    .padding(.horizontal, 10).padding(.vertical, 8)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    
                    Button(action: {
                        searchText = ""
                        inputSearch = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color("gray")).opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .onAppear{
                    inputSearch = searchText
                    disableTextField = false
                }
                .onDisappear{
                    disableTextField = true
                }
                
                ForEach(Array(gameViewModel.searchGame.results.enumerated()), id:\.offset){
                    offser, games in
                    
                    ContentItemView(games: games)
                }
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
