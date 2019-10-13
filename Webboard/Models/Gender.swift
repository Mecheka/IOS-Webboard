//
//  Gender.swift
//  Webboard
//
//  Created by Suriya on 13/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

enum Gender: Int,  CaseIterable {
    case men = 1
    case women = 2
    
    var text: String {
        switch self {
        case .men:
            return "ชาย"
        default:
            return "ผู้หญิง"
        }
    }
}
