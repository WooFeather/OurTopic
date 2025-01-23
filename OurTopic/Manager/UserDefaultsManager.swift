//
//  UserDefaultsManager.swift
//  OurTopic
//
//  Created by 조우현 on 1/23/25.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    var isSigned: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isSigned")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSigned")
        }
    }
}
