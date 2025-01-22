//
//  UnplashRequest.swift
//  OurTopic
//
//  Created by 조우현 on 1/21/25.
//

import Foundation
import Alamofire

enum UnsplashRequest {
    case searchPhoto(query: String, page: Int, sort: RequestSort, color: String)
    case photoStatistics(id: String)
    case topicPhoto(topicId: String)
    case randomPhoto
    
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .searchPhoto(let query, let page, let sort, let color):
            return URL(string: baseURL + "search/photos?query=\(query)&page=\(page)&order_by=\(sort)&\(color)")!
        case .photoStatistics(let id):
            return URL(string: baseURL + "photos/\(id)/statistics")!
        case .topicPhoto(let topicId):
            return URL(string: baseURL + "topics/\(topicId)/photos")!
        case .randomPhoto:
            return URL(string: baseURL + "photos/random")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.unsplashAccessKey]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .searchPhoto:
            return [
                "per_page": "20"
            ]
        case .photoStatistics:
            return [:]
        case .topicPhoto:
            return [
                "page": "1"
            ]
        case .randomPhoto:
            return [
                "count": "10"
            ]
        }
    }
}
