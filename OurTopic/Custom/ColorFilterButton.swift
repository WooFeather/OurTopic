//
//  ColorFilterButton.swift
//  OurTopic
//
//  Created by 조우현 on 1/20/25.
//

import UIKit

final class ColorFilterButton: UIButton {
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        
        configuration = .colorFilterButtonStyle()
        
        setTitle("\(title)", for: .normal)
        let image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        tintColor = color
        setTitleColor(.black, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = .systemGray6
        setBackgroundColor(.systemBlue, for: .selected)
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
