//
//  AuthorizationManager.swift
//  Webboard
//
//  Created by Suriya on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

class AuthorizationManager: NSObject {
    static let shared = AuthorizationManager()
    
    fileprivate let TOKEN_KEY = "token"
    
    var token: String? {
        set{
            if let text = newValue{
                // Save Token
                setToken(token: text)
            }else{
                // Clear Token
                clearToken()
            }
        }
        
        get{
            return UserDefaults.standard.string(forKey: TOKEN_KEY)
        }
    }
    
    private override init() {
        
    }
    
    private func setToken(token: String) {
        print("Save token: \(token)")
        UserDefaults.standard.set(token, forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
    
    private func clearToken() {
        print("Clear token")
        UserDefaults.standard.removeObject(forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
}
