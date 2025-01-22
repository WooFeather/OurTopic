//
//  PhotoDetailViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: BaseViewController {

    var idContents: String?
    var imageURLContents: String?
    var imageWidthContents: Int?
    var imageHeightContents: Int?
    var postDateContents: String?
    var userNameContents: String?
    var userProfileImageContents: String?
    
    var monthViews = 0
    var monthDownloads = 0
    
    var photoDetailView = PhotoDetailView()
    
    override func loadView() {
        view = photoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
    }
    
    override func configureView() {
        super.configureView()
        
        photoDetailView.profileImageView.kf.setImage(with: URL(string: userProfileImageContents ?? ""))
        photoDetailView.profileNameLabel.text = userNameContents
        photoDetailView.postDateLabel.text = "\(postDateContents?.toDate()?.toString() ?? "") 게시됨"
        photoDetailView.photoImageView.kf.setImage(with: URL(string: imageURLContents ?? ""))
        photoDetailView.sizeLabel.text = "\(imageWidthContents ?? 0) x \(imageHeightContents ?? 0)"
    }
    
    func callRequest() {
        guard let id = idContents else {
            print("id 가져오기 실패")
            return
        }

        NetworkManager.shared.callUnsplashAPI(api: .photoStatistics(id: id), type: Statistics.self) { value in
            
            for i in 0..<value.views.historical.values.count {
                self.monthViews += value.views.historical.values[i].value
            }
            
            let formattedViews = NumberFormattingManager.shared.numberFormatting(number: self.monthViews)
            self.photoDetailView.viewsLabel.text = "\(formattedViews ?? "")"
            
            for i in 0..<value.downloads.historical.values.count {
                self.monthDownloads += value.downloads.historical.values[i].value
            }
            
            let formattedDownloads = NumberFormattingManager.shared.numberFormatting(number: self.monthDownloads)
            self.photoDetailView.downloadLabel.text = "\(formattedDownloads ?? "")"
        } failHandler: { statusCode in
            let title = NetworkStatus(rawValue: statusCode)?.title ?? "정의되지 않은 ERROR"
            let message = NetworkStatus(rawValue: statusCode)?.message ?? "예상치 못한 에러입니다."
            self.showAlert(title: title, message: message, button: "닫기") {
                self.dismiss(animated: true)
            }
        }
    }
}
