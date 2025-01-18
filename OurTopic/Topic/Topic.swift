//
//  Topic.swift
//  OurTopic
//
//  Created by 조우현 on 1/19/25.
//

import Foundation

struct Topic: Decodable {
    let id: String
    let postDate: String
    let width: Int
    let height: Int
    let urls: PhotoURL
    let likes: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case postDate = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}
