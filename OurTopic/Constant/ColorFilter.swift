//
//  ColorFilter.swift
//  OurTopic
//
//  Created by 조우현 on 1/20/25.
//

import UIKit

enum ColorFilter: CaseIterable {
    case black
    case white
    case yellow
    case red
    case purple
    case green
    case blue
    
    var title: String {
        switch self {
        case .black:
            return "블랙"
        case .white:
            return "화이트"
        case .yellow:
            return "옐로우"
        case .red:
            return "레드"
        case .purple:
            return "퍼플"
        case .green:
            return "그린"
        case .blue:
            return "블루"
        }
    }
    
    var color: UIColor {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        case .yellow:
            return .yellow
        case .red:
            return .red
        case .purple:
            return .purple
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
    
    var urlString: String {
        switch self {
        case .black:
            return "&color=black"
        case .white:
            return "&color=white"
        case .yellow:
            return "&color=yellow"
        case .red:
            return "&color=red"
        case .purple:
            return "&color=purple"
        case .green:
            return "&color=green"
        case .blue:
            return "&color=blue"
        }
    }
}
