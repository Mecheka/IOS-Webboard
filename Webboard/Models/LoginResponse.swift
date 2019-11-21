//
//  LoginResponse.swift
//  Webboard
//
//  Created by Suriya on 27/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import Foundation

struct LoginResponse : Codable {
    let id : Int?
    let string : String?
    let userID : Int?
    let expiresAt : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case string = "string"
        case userID = "userID"
        case expiresAt = "expiresAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        string = try values.decodeIfPresent(String.self, forKey: .string)
        userID = try values.decodeIfPresent(Int.self, forKey: .userID)
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
    }

}
