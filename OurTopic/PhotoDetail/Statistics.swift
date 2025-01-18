//
//  Statistics.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import Foundation

struct Statistics: Decodable {
    let downloads: PhotoDownloads
    let views: PhotoViews
}

struct PhotoDownloads: Decodable {
    let historical: DownloadHistory
}

struct DownloadHistory: Decodable {
    let values: [DownloadValue]
}

struct DownloadValue: Decodable {
    let value: Int
}

struct PhotoViews: Decodable {
    let historical: ViewHistory
}

struct ViewHistory: Decodable {
    let values: [ViewValue]
}

struct ViewValue: Decodable {
    let value: Int
}
