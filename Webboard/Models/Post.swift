//
//  PostResponce.swift
//  Webboard
//
//  Created by Suriya on 27/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import Foundation

struct Post : Codable {
    let createAt : String
    let id : Int
    let title : String
    let content : String
    let userID : Int

//    enum CodingKeys: String, CodingKey {
//
//        case createAt = "createAt"
//        case id = "id"
//        case title = "title"
//        case content = "content"
//        case userID = "userID"
//    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createAt = try values.decode(String.self, forKey: .createAt)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        content = try values.decode(String.self, forKey: .content)
        userID = try values.decode(Int.self, forKey: .userID)
    }

}
