//
//  PhotoDetailViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: BaseViewController {

    var imageURLContents: String?
    var imageWidthContents: Int?
    var imageHeightContents: Int?
    var postDateContents: String?
    var userNameContents: String?
    var userProfileImageContents: String?
    
    var photoDetailView = PhotoDetailView()
    
    override func loadView() {
        view = photoDetailView
    }

    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureView() {
        super.configureView()
        
        photoDetailView.profileImageView.kf.setImage(with: URL(string: userProfileImageContents ?? ""))
        photoDetailView.profileNameLabel.text = userNameContents
        photoDetailView.postDateLabel.text = "\(postDateContents?.toDate()?.toString() ?? "") 게시됨"
        photoDetailView.photoImageView.kf.setImage(with: URL(string: imageURLContents ?? ""))
        photoDetailView.sizeLabel.text = "\(imageWidthContents ?? 0) x \(imageHeightContents ?? 0)"
    }
    
    override func configureEssential() {
        
    }
}
