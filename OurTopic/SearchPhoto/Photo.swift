//
//  Photo.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import Foundation

struct Photo: Decodable {
    let total: Int
    let results: [PhotoDetail]
}

struct PhotoDetail: Decodable {
    let created_at: String // "2021-06-08T19:48:47Z"
    let width: Int
    let height: Int
    let urls: PhotoURL
    let likes: Int
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
