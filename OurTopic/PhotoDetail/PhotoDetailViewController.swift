//
//  PhotoDetailViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import Kingfisher

final class PhotoDetailViewController: BaseViewController {
    
    private var photoDetailView = PhotoDetailView()
    let viewModel = PhotoDetailViewModel()
    
    override func loadView() {
        view = photoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bindData() {
        viewModel.input.viewDidLoadTrigger.value = ()
        
        viewModel.output.monthViews.bind { text in
            self.photoDetailView.viewsLabel.text = text
        }
        
        viewModel.output.monthDownloads.bind { text in
            self.photoDetailView.downloadLabel.text = text
        }
        
        viewModel.output.failHandler.lazyBind { _ in
            self.showAlert(title: self.viewModel.failAlertTitle, message: self.viewModel.failAlertMessage, button: "닫기") {
                self.dismiss(animated: true)
            }
        }
        
        viewModel.output.userProfileImageContents.bind { text in
            self.photoDetailView.profileImageView.kf.setImage(with: URL(string: text ?? ""))
        }
        
        viewModel.output.userNameContents.bind { text in
            self.photoDetailView.profileNameLabel.text = text
        }
        
        viewModel.output.postDateContents.bind { text in
            self.photoDetailView.postDateLabel.text = "\(text?.toDate()?.toString() ?? "") 게시됨"
        }
        
        viewModel.output.imageURLContents.bind { text in
            self.photoDetailView.photoImageView.kf.setImage(with: URL(string: text ?? ""))
        }
        
        viewModel.output.imageWidthContents.bind { width in
            self.viewModel.output.imageHeightContents.bind { height in
                self.photoDetailView.sizeLabel.text = "\(width ?? 0) x \(height ?? 0)"
            }
        }
    }
}
