//
//  Profile.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 14/9/21.
//

import Foundation

struct Profile {
    static let nameKey = "keyName"
    static let emailKey = "keyEmail"
    static let cityKey = "keyCity"
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "Rasyid Ridla"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    
    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? "RasyidRidla298@gmail.com"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }
    
    static var city: String {
        get {
            return UserDefaults.standard.string(forKey: cityKey) ?? "Yogyakarta"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: cityKey)
        }
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
