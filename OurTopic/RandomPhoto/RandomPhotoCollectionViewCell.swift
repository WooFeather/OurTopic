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
    
    let profileImageView = UIImageView()
    let profileNameLabel = UILabel()
    let postDateLabel = UILabel()
    private var randomImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(randomImageView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(postDateLabel)
    }
    
    override func configureLayout() {
        randomImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(randomImageView.snp.leading).offset(18)
            make.bottom.equalTo(randomImageView.snp.bottom).offset(-18)
            make.size.equalTo(40)
        }
        
        postDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(14)
            make.bottom.equalTo(randomImageView.snp.bottom).offset(-20)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
            make.bottom.equalTo(postDateLabel.snp.top)
        }
    }
    
    override func configureView() {
        randomImageView.backgroundColor = .brown
        randomImageView.contentMode = .scaleAspectFill
        
        profileImageView.backgroundColor = .gray
        DispatchQueue.main.async { [self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
            profileImageView.clipsToBounds = true
        }
        
        profileNameLabel.font = .systemFont(ofSize: 16)
        profileNameLabel.textColor = .white
        
        postDateLabel.font = .systemFont(ofSize: 12, weight: .heavy)
        postDateLabel.textColor = .white
    }
    
    func configureData(data: PhotoDetail) {
        randomImageView.kf.setImage(with: URL(string: data.urls.regular))
        profileImageView.kf.setImage(with: URL(string: data.user.profileImage.image))
        profileNameLabel.text = data.user.name
        postDateLabel.text = "\(data.postDate.toDate()?.toString() ?? "") 게시됨"
    }
}
