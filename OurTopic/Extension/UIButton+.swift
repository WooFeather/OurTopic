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
    
    static func colorFilterButtonStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15)
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12)
        return configuration
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
