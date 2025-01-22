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

    func callUnsplashAPI<T: Decodable>(api: UnsplashRequest,
                         type: T.Type,
                         completionHandler: @escaping (T) -> Void,
                         failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                print(response.response?.statusCode ?? 000)
                print(response.response?.url ?? "")
                
                switch response.result {
                case .success(let value):
                    print("✅SUCCESS")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
}
