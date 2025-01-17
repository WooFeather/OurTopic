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
    
    enum CodingKeys: String, CodingKey {
        case postDate = "created_at"
        case width
        case height
        case urls
        case likes
    }
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
