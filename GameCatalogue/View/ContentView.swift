//
//  ContentView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoriteView()
                .tabItem{
                    Image(systemName: "")
                    Text("Favorite")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "")
                    Text("Profile")
                }
        }.accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
