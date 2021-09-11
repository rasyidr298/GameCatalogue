//
//  ItemView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct itemHomeView: View {
    @EnvironmentObject var gameViewModel : GamesViewModel
    
    var body: some View {
        ScrollView(.vertical){
            ForEach(Array(gameViewModel.games.results.enumerated()), id:\.offset){
                offser, games in
                
                ContentItemView(games: games)
                
            }
            
        }
    }
}

struct itemSearchlView: View {
    @EnvironmentObject var gameViewModel : GamesViewModel
    
    var body: some View {
        
        ScrollView(.vertical){
            ForEach(Array(gameViewModel.searchGame.results.enumerated()), id:\.offset){
                offser, games in
                
                ContentItemView(games: games)
            }
            
        }
    }
}

struct ContentItemView : View{
    var games : Games
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
            
            VStack(alignment: .leading, spacing: nil){
                
                WebImage(url: URL(string : "\(games.background_image ?? "")"))
                    .resizable()
                    .placeholder {Rectangle().foregroundColor(.gray)}
                    .aspectRatio(contentMode: .fit)
                    .clipShape(CustomShape(corner: [.bottomLeft, .bottomRight], radius: 10))
                    .transition(.fade(duration: 0.5))
                
                VStack(alignment: .leading){
                    
                    Text(games.name ?? "")
                        .font(.title)
                    
                    Text(games.released ?? "")
                        .font(.callout)
                }
                .padding(EdgeInsets(top : 0, leading :20, bottom : 20, trailing: 20))
                
            }
            
            HStack{
                ForEach(0..<Int((games.rating?.rounded(.down))!)){rating in
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
            
        }
        .background(Color.secondary)
        .cornerRadius(10)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        itemHomeView()
            .environmentObject(GamesViewModel())
    }
}
