//
//  UserDefaultManager.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import Foundation

enum UserDefaultKey: String {
    case timerInfo = "timerInfo"
}

class UserDefaultManager {
    static private let userDefault = UserDefaults.standard

    class func setValue<T: Encodable>(with data: T, key: UserDefaultKey) {
        let encoded = try? JSONEncoder().encode(data)
        self.userDefault.setValue(encoded, forKey: key.rawValue)
    }
    
    class func getValue<T: Decodable>(with key: UserDefaultKey) -> T? {
        if let data = self.userDefault.data(forKey: key.rawValue) {
            let model = try? JSONDecoder().decode(T.self, from: data)
            return model
        }
        
        return nil
    }
}
