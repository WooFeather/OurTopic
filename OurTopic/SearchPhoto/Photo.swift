//
//  Photo.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import Foundation

struct Photo: Decodable {
    let totalCount: Int
    let results: [PhotoDetail]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total"
        case results
    }
}

struct PhotoDetail: Decodable {
    let postDate: String // "2021-06-08T19:48:47Z"
    let width: Int
    let height: Int
    let urls: PhotoURL
    let likes: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case postDate = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}

struct User: Decodable {
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "medium"
    }
}
