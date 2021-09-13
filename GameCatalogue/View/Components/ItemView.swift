//
//  ItemView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentItemView: View {

    @EnvironmentObject var gameViewModel: GamesViewModel
    var games: Games

    var body: some View {

        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {

            VStack(alignment: .leading, spacing: nil) {

                WebImage(url: URL(string: "\(games.background_image ?? "")"))
                    .resizable()
                    .placeholder {Rectangle().foregroundColor(Color("gray"))}
                    .aspectRatio(contentMode: .fit)
                    .clipShape(CustomShape(corner: [.bottomLeft, .bottomRight], radius: 10))
                    .transition(.fade(duration: 0.5))

                VStack(alignment: .leading) {

                    Text(games.name ?? "")
                        .font(.title)

                    Text(games.released ?? "")
                        .font(.callout)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))

            }

            RatingStar(rate: Int(games.rating!), size: 15).padding(.bottom, 0)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))

        }
        .cornerRadius(10)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        .onTapGesture {
            gameViewModel.showModal.toggle()
            gameViewModel.itemClickId = games.id!

        }.sheet(isPresented: $gameViewModel.showModal, content: {
            DetailView()
                .environmentObject(gameViewModel)
        })

    }
}

struct FavoriteItemView: View {

    @EnvironmentObject var gameViewModel: GamesViewModel
    var games: Game

    var body: some View {

        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {

            VStack(alignment: .leading, spacing: nil) {

                WebImage(url: URL(string: "\(games.backgroundImage ?? "")"))
                    .resizable()
                    .placeholder {Rectangle().foregroundColor(Color("gray"))}
                    .aspectRatio(contentMode: .fit)
                    .clipShape(CustomShape(corner: [.bottomLeft, .bottomRight], radius: 10))
                    .transition(.fade(duration: 0.5))

                VStack(alignment: .leading) {

                    Text(games.name ?? "")
                        .font(.title)

                    Text(games.released ?? "")
                        .font(.callout)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))

            }

            RatingStar(rate: Int(games.rating), size: 15).padding(.bottom, 0)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))

        }
        .cornerRadius(10)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))

    }
}

// struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentItemView()
//    }
// }
