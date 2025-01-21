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
    
    func callSearchPhotoAPI(query: String, page: Int, sort: RequestSort, color: String, completionHandler: @escaping (Photo) -> Void) {
        let url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20&order_by=\(sort)\(color)"
        let header: HTTPHeaders = [
            "Authorization": APIKey.unsplashAccessKey
        ]
        print(#function, url)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Photo.self) { response in
                print(response.response?.statusCode ?? 000)
                
                switch response.result {
                case .success(let value):
                    print("✅SUCCESS", value.totalCount)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callPhotoStatisticsAPI(id: String, completionHandler: @escaping (Statistics) -> Void) {
        let url = "https://api.unsplash.com/photos/\(id)/statistics"
        let header: HTTPHeaders = [
            "Authorization": APIKey.unsplashAccessKey
        ]
        print(#function, url)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Statistics.self) { response in
                print(response.response?.statusCode ?? 000)
                
                switch response.result {
                case .success(let value):
                    print("✅SUCCESS")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callTopicPhotoAPI(
        topicId: String,
        completionHandler: @escaping ([PhotoDetail]) -> Void,
        failHandler: @escaping () -> Void
    ) {
        let url = "https://api.unsplash.com/topics/\(topicId)/photos?page=1"
        let header: HTTPHeaders = [
            "Authorization": APIKey.unsplashAccessKey
        ]
        print(#function, url)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: [PhotoDetail].self) { response in
                print(response.response?.statusCode ?? 000)
                
                switch response.result {
                case .success(let value):
                    print("✅SUCCESS")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
