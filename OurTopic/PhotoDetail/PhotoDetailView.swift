//
//  PhotoDetailView.swift
//  OurTopic
//
//  Created by 조우현 on 1/18/25.
//

import UIKit
import SnapKit

final class PhotoDetailView: BaseView {
    
    let profileImageView = UIImageView()
    let profileNameLabel = UILabel()
    let postDateLabel = UILabel()
    let photoImageView = UIImageView()
    let sizeLabel = UILabel()
    let viewsLabel = UILabel()
    let downloadLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let infoTitleLabel = UILabel()
    private let infoSizeLabel = UILabel()
    private let infoViewsLabel = UILabel()
    private let infoDownloadLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [profileImageView, profileNameLabel, postDateLabel, photoImageView, infoTitleLabel, infoSizeLabel, infoViewsLabel, infoDownloadLabel, sizeLabel, viewsLabel, downloadLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(12)
            make.size.equalTo(40)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        postDateLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(14)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(infoTitleLabel.snp.top).offset(-16)
            make.height.equalTo(500)
        }
        
        infoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }
        
        infoSizeLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalTo(infoTitleLabel.snp.trailing).offset(60)
            make.height.equalTo(17)
            make.width.equalTo(60)
        }
        
        infoViewsLabel.snp.makeConstraints { make in
            make.top.equalTo(infoSizeLabel.snp.bottom).offset(12)
            make.centerX.equalTo(infoSizeLabel.snp.centerX)
            make.height.equalTo(17)
            make.width.equalTo(60)
        }
        
        infoDownloadLabel.snp.makeConstraints { make in
            make.top.equalTo(infoViewsLabel.snp.bottom).offset(12)
            make.centerX.equalTo(infoViewsLabel.snp.centerX)
            make.height.equalTo(17)
            make.width.equalTo(60)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoSizeLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        
        viewsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoViewsLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        
        downloadLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoDownloadLabel.snp.centerY)
            make.bottom.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(17)
        }
    }
    
    override func configureView() {
        profileImageView.backgroundColor = .gray
        DispatchQueue.main.async { [self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
            profileImageView.clipsToBounds = true
        }
        
        profileNameLabel.font = .systemFont(ofSize: 16)
        
        postDateLabel.font = .systemFont(ofSize: 12, weight: .heavy)
        
        photoImageView.backgroundColor = .gray
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
        infoTitleLabel.text = "정보"
        infoTitleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        infoSizeLabel.text = "크기"
        infoSizeLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        infoViewsLabel.text = "조회수"
        infoViewsLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        infoDownloadLabel.text = "다운로드"
        infoDownloadLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        sizeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        sizeLabel.textColor = .gray
        
        viewsLabel.font = .systemFont(ofSize: 14, weight: .bold)
        viewsLabel.textColor = .gray
        
        downloadLabel.font = .systemFont(ofSize: 14, weight: .bold)
        downloadLabel.textColor = .gray
    }
}
