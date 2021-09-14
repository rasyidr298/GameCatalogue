//
//  EditProfileView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 14/9/21.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State private var showingAlert = false
    @State var name = ""
    @State var email = ""
    @State var city = ""
    
    var body: some View {
        VStack(alignment: .center){
            VStack(alignment: .leading){
                Text("Name")
                TextField("name", text: $name)
                    .padding()
                    .background(Color("gray"))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .textContentType(.none)
                
                Text("Email")
                TextField("name", text: $email)
                    .padding()
                    .background(Color("gray"))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                
                Text("City")
                TextField("city", text: $city)
                    .padding()
                    .background(Color("gray"))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .padding(.bottom, 20)
                    .textContentType(.telephoneNumber)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Alert"),
                      message: Text("All fields must be filled"),
                      dismissButton: .default(Text("OK"))
                )
            }
            
            Button(action: {
                if name.isEmpty || email.isEmpty || city.isEmpty {
                    showingAlert = true
                } else {
                    profileViewModel.saveProfil(name, email, city)
                    profileViewModel.showModal = false
                }
            }, label: {
                Text("Update").bold().font(.callout).foregroundColor(.white)
            })
            .frame(width: 200)
            .padding()
            .background(Color.green)
            .cornerRadius(15)
            
        }.padding()
        .onAppear {
            Profile.synchronize()
            self.name = Profile.name
            self.email = Profile.email
            self.city = Profile.city
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
