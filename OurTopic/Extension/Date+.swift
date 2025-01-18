//
//  Bata+.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 dd일"
        return dateFormatter.string(from: self)
    }
}
