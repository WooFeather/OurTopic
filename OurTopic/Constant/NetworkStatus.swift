//
//  NetworkStatus.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import Foundation

enum NetworkStatus: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case unsplashError1 = 500
    case unsplashError2 = 503
    case networkError = 0
    
    var title: String {
        switch self {
        case .badRequest:
            return "매개변수 누락 ERROR!"
        case .unauthorized:
            return "액세스 토큰 ERROR!"
        case .forbidden:
            return "권한 ERROR!"
        case .notFound:
            return "리소스 ERROR!"
        case .unsplashError1:
            return "API ERROR!"
        case .unsplashError2:
            return "API ERROR!"
        case .networkError:
            return "네트워크 ERROR!"
        }
    }
    
    var message: String {
        switch self {
        case .badRequest:
            return "필수 매개변수가 누락되었습니다."
        case .unauthorized:
            return "액세스 토큰이 잘못되었습니다."
        case .forbidden:
            return "요청을 수행할 권한이 없습니다."
        case .notFound:
            return "요청하신 리소스가 존재하지 않습니다."
        case .unsplashError1:
            return "API에 문제가 발생했습니다."
        case .unsplashError2:
            return "API에 문제가 발생했습니다."
        case .networkError:
            return "네트워크 에러입니다."
        }
    }
}
