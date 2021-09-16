//
//  ProfileView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                    HStack {
                        Spacer()
                        Image("img_profile")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100, alignment: .center)
                        Spacer()
                    }.padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                    
                    Button(action: {
                        profileViewModel.showModal = true
                    }, label: {
                        Image(systemName: "pencil.circle.fill").resizable().frame(width: 35, height: 35).foregroundColor(.green).padding(.trailing, 40)
                    })
                }).sheet(isPresented: $profileViewModel.showModal, content: {
                    EditProfileView()
                })
                
                Form {
                    Section(header:
                                Text("Biodata")
                                .font(.body)
                                .fontWeight(.bold)) {
                        Text(profileViewModel.name)
                        Text(profileViewModel.email)
                        Text(profileViewModel.city)
                        Text("linkedin.com/in/rasyidr298/")
                        Text("github.com/rasyidr298")
                    }
                }
                .navigationBarTitle("Account")
            }
            .onAppear {
                profileViewModel.fetchProfile()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
