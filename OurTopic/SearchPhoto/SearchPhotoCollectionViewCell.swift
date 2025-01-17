//
//  PhotoSearchCollectionViewCell.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import SnapKit

class SearchPhotoCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "SearchPhotoCollectionViewCell"
    
    let photoImageView = UIImageView()
    let starButton = UIButton()
    
    // 네트워킹 이후 수정 예정
    var starCount = 3800
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(starButton)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starButton.snp.makeConstraints { make in
            make.leading.equalTo(photoImageView.snp.leading).offset(10)
            make.bottom.equalTo(photoImageView.snp.bottom).offset(-10)
            make.height.equalTo(28)
        }
    }
    
    override func configureView() {
        photoImageView.backgroundColor = .brown
        
        let formattedCount = NumberFormattingManager.shared.numberFormatting(number: starCount)
        starButton.setTitle("\(formattedCount ?? "")", for: .normal)
        starButton.setTitleColor(.white, for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        starButton.tintColor = .yellow
        starButton.layer.cornerRadius = 14
        starButton.backgroundColor = .starBackground
        starButton.configuration = .starButtonStyle()
        starButton.isUserInteractionEnabled = false
    }
}
