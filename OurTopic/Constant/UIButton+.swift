//
//  UIButton+.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

extension UIButton.Configuration {
    static func sortButtonStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        // enum으로 두 가지 정렬 이름 들어갈 예정
        configuration.title = "최신순  "
        configuration.image = UIImage(systemName: "arrow.up.arrow.down.square")
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.imagePlacement = .leading
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .red
        configuration.baseForegroundColor = .black
        return configuration
    }
}
