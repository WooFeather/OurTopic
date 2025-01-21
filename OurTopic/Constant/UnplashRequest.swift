//
//  UnplashRequest.swift
//  OurTopic
//
//  Created by 조우현 on 1/21/25.
//

import Foundation
import Alamofire

enum UnplashRequest {
    case searchPhoto(query: String, page: Int, sort: RequestSort, color: String)
    case photoStatistics(id: String)
    case topicPhoto(topicId: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .searchPhoto:
            return URL(string: baseURL + "search/photos")!
        case .photoStatistics(let id):
            return URL(string: baseURL + "photos/\(id)/statistics")!
        case .topicPhoto(let topicId):
            return URL(string: baseURL + "topics/\(topicId)/photos")!
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
        case .searchPhoto(let query, let page, let sort, let color):
            return [
                "query": query,
                "page": page,
                "per_page": 20,
                "order_by": sort,
                "color": color
            ]
        case .photoStatistics(id: let id):
            return [:]
        case .topicPhoto(topicId: let topicId):
            return [
                "page": "1"
            ]
        }
    }
}
