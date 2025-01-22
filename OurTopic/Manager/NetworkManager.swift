//
//  NetworkManager.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import Foundation
import Alamofire
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }

    func callUnsplashAPI<T: Decodable>(api: UnsplashRequest,
                         type: T.Type,
                         completionHandler: @escaping (T) -> Void,
                        failHandler: @escaping (Int) -> Void
    ) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<503)
            .responseDecodable(of: T.self) { response in
                print(response.response?.url ?? "")
                
                switch response.result {
                case .success(let value):
                    let statusCode = (response.response?.statusCode ?? 000) as Int
                    switch statusCode {
                    case 200:
                        completionHandler(value)
                        print("200 - OK : Everything worked as expected")
                    default:
                        break
                    }
                case .failure(_):
                    let statusCode = (response.response?.statusCode ?? 000) as Int
                    switch statusCode {
                    case 400:
                        print("400 - Bad Request : The request was unacceptable, often due to missing a required parameter")
                        failHandler(400)
                    case 401:
                        print("401 - Unauthorized : Invalid Access Token")
                        failHandler(401)
                    case 403:
                        print("403 - Forbidden : Missing permissions to perform request")
                        failHandler(403)
                    case 404:
                        print("404 - Not Found : The requested resource doesn’t exist")
                        failHandler(404)
                    case 500:
                        print("Something went wrong on Unsplash end")
                        failHandler(500)
                    case 503:
                        print("Something went wrong on Unsplash end")
                        failHandler(503)
                    default:
                        print("NetworkError")
                        failHandler(0)
                    }
                }
            }
    }
}
