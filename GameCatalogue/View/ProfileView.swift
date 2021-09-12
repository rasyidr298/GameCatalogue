//
//  ProfileView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
          VStack {
            HStack {
              Image("img_profile")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
            }
            Form {
              Section(header:
                        Text("Biodata")
                        .font(.body)
                        .fontWeight(.bold)) {
                Text("Rasyid Ridla")
                Text("Rasyidridla298@gmail.com")
                HStack {
                  Text("+62")
                  Text("87715441292")
                }
                Text("linkedin.com/in/rasyidr298/")
                Text("github.com/rasyidr298")
              }
            }
            .navigationBarTitle("Account")
          }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
