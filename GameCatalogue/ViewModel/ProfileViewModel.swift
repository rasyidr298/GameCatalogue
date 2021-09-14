//
//  ProfileViewModel.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 14/9/21.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var showModal = false
    @Published var name = ""
    @Published var email = ""
    @Published var city = ""
    
    func fetchProfile(){
        Profile.synchronize()
        DispatchQueue.main.async {
            self.name = Profile.name
            self.email = Profile.email
            self.city = Profile.city
        }
    }
    
    func saveProfil(_ name: String, _ email: String, _ city: String) {
        Profile.name = name
        Profile.email = email
        Profile.city = city
        
        fetchProfile()
    }
}
