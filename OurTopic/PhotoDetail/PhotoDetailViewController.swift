//
//  PhotoDetailViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

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
    }
    
    override func configureEssential() {
        
    }
}
