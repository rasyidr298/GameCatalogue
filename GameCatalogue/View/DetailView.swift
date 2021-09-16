//
//  DetailView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    @EnvironmentObject var gameViewModel: GamesViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        
        ZStack {
            if gameViewModel.noInternet {
                AnyView(ReconectView(message: "No Internet Connection..", action: {
                    gameViewModel.detailGames(idGames: gameViewModel.itemClickId)
                }))
            } else if gameViewModel.isLoading {
                AnyView(LoadingAnim())
            } else {
                ContentDetailView()
            }
        }
        .onAppear {
            favoriteViewModel.checkIdLocal(idGames: gameViewModel.itemClickId)
            gameViewModel.detailGames(idGames: gameViewModel.itemClickId)
        }
    }
}

struct ContentDetailView: View {
    
    @EnvironmentObject var gameViewModel: GamesViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @Environment(\.managedObjectContext) var context
    @Environment(\.colorScheme) var colorSchema
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0, content: {
                
                WebImage(url: URL(string: "\(gameViewModel.detailGames.backgroundImage ?? "")"))
                    .resizable()
                    .placeholder {Rectangle().foregroundColor(Color("gray"))}
                    .aspectRatio(contentMode: .fit)
                    .transition(.fade(duration: 0.5))
                
                HStack {
                    Text("")
                    Spacer()
                    Button(action: {
                        if favoriteViewModel.isFav{
                            favoriteViewModel.deleteFavorite(context: context, idGame: gameViewModel.itemClickId)
                            favoriteViewModel.isFav = false
                        }else{
                            favoriteViewModel.addFavorite(context: context, gameViewModel.detailGames)
                            favoriteViewModel.isFav = true
                        }
                    }, label: {
                        Image(systemName: favoriteViewModel.isFav ? "heart.fill" : "heart")
                            .resizable().frame(width: 30, height: 30)
                    })
                    .foregroundColor(Color.red).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                }
                
                .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                .background(colorSchema == .dark ? Color(UIColor.systemBackground) : Color.white)
                .clipShape(CustomShape(corner: [.topLeft, .topRight], radius: 20))
                .padding(EdgeInsets(top: -15, leading: 0, bottom: 0, trailing: 0))
                
                VStack(alignment: .leading) {
                    
                    Text(gameViewModel.detailGames.name ?? "")
                        .font(.title).padding(.top, -25)
                    
                    Text(gameViewModel.detailGames.released ?? "")
                        .font(.callout)
                    
                    RatingStar(rate: Int(gameViewModel.detailGames.rating ?? 0.0), size: 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(Array(gameViewModel.detailGames.genres.enumerated()), id: \.offset) {
                                _, genre in
                                
                                Text(genre?.name ?? "")
                                    .font(.callout)
                                    .padding(3)
                                    .background(Color.green)
                                    .clipShape(CustomShape(corner: [.allCorners], radius: 5))
                                    .multilineTextAlignment(.center)
                                Text(" ")
                            }
                        }
                    }.padding(.top, 10)
                    
                    Text("Platform Support :").font(.title3).bold().padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            ForEach(Array(gameViewModel.detailGames.platforms.enumerated()), id: \.offset) {
                                _, platform in
                                
                                Text(platform?.platform?.name ?? "")
                                    .font(.callout)
                                    .frame(width: 90, height: 80)
                                    .background(Color.green)
                                    .clipShape(CustomShape(corner: [.allCorners], radius: 10))
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    
                    Text("Description :")
                        .bold()
                        .font(.title2).padding(.top, 20)
                    Text(gameViewModel.detailGames.description?.withoutHtmlTags() ?? "").font(.body).padding(.top, 10)
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                
            })
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
