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
        configuration.image = UIImage(systemName: "arrow.up.arrow.down.square")
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.imagePlacement = .leading
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        return configuration
    }
    
    static func starButtonStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12)
        return configuration
    }
}
