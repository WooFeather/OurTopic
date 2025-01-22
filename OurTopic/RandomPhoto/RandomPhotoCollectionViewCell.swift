//
//  RandomPhotoCollectionViewCell.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import UIKit
import Kingfisher
import SnapKit

final class RandomPhotoCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "RandomPhotoCollectionViewCell"
    
    private var randomImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(randomImageView)
    }
    
    override func configureLayout() {
        randomImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        randomImageView.backgroundColor = .brown
        randomImageView.contentMode = .scaleAspectFill
    }
    
    func configureData(data: PhotoDetail) {
        randomImageView.kf.setImage(with: URL(string: data.urls.regular))
    }
}
