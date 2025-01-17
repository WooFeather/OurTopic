//
//  NetworkManager.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func callSearchPhotoAPI(query: String, page: Int, sort: RequestSort) {
        let url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20&order_by=\(sort)"
        let header: HTTPHeaders = [
            // 추후작성예정
        ]
        print(#function, url)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseString { response in
                print(response)
            }
    }
}
