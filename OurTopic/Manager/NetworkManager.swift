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
    
    func callSearchPhotoAPI(api: UnsplashRequest, completionHandler: @escaping (Photo) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString) ,headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Photo.self) { response in
                print(response.response?.statusCode ?? 000)
                print(response.response?.url ?? "")
                
                switch response.result {
                case .success(let value):
                    print("✅SUCCESS", value.totalCount)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callPhotoStatisticsAPI(api: UnsplashRequest, completionHandler: @escaping (Statistics) -> Void) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
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
    
    func callTopicPhotoAPI(api: UnsplashRequest,
        completionHandler: @escaping ([PhotoDetail]) -> Void,
        failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: [PhotoDetail].self) { response in
                print(response.response?.statusCode ?? 000)
                print(response.response?.url ?? "")
                
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
