//
//  TopicViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

final class TopicViewController: BaseViewController {

    private var topicView = TopicView()
    
    private var firstList: [PhotoDetail] = []
    private var secondList: [PhotoDetail] = []
    private var thirdList: [PhotoDetail] = []
    
    private let topicQuery = ["golden-hour", "business-work", "architecture-interior"]
    private lazy var lists = [firstList, secondList, thirdList]
    
    override func loadView() {
        view = topicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("♥️lists[0] \(self.lists[0])")
//        print("💙firstList\(self.firstList)")
        
        callRequest()
    }
    
    override func configureEssential() {
        navigationItem.title = "OUR TOPIC"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: #selector(profileButtonTapped)), animated: true)
        topicView.firstTopicCollectionView.delegate = self
        topicView.firstTopicCollectionView.dataSource = self
        topicView.secondTopicCollectionView.delegate = self
        topicView.secondTopicCollectionView.dataSource = self
        topicView.thirdTopicCollectionView.delegate = self
        topicView.thirdTopicCollectionView.dataSource = self
    }
    
    @objc private func profileButtonTapped() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func callRequest() {
        
        let group = DispatchGroup()
        
        for i in 0..<topicQuery.count {
            group.enter()
            NetworkManager.shared.callUnsplashAPI(api: .topicPhoto(topicId: topicQuery[i]), type: [PhotoDetail].self) { value in
                self.lists[i] = value
                group.leave()
//                print("♥️lists[0] \(self.lists[0])")
//                print("💙firstList\(self.firstList)")
            } failHandler: { statusCode in
                let title = NetworkStatus(rawValue: statusCode)?.title ?? "정의되지 않은 ERROR"
                let message = NetworkStatus(rawValue: statusCode)?.message ?? "예상치 못한 에러입니다."
                self.showAlert(title: title, message: message, button: "닫기") {
                    self.dismiss(animated: true)
                }
            }
        }

        group.notify(queue: .main) {
            print("네트워크 통신 종료")
            self.topicView.firstTopicCollectionView.reloadData()
            self.topicView.secondTopicCollectionView.reloadData()
            self.topicView.thirdTopicCollectionView.reloadData()
            
//            print("♥️lists[0] \(self.lists[0])")
//            print("💙firstList\(self.firstList)")
        }
    }
}

extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topicView.firstTopicCollectionView {
            return lists[0].count
        } else if collectionView == self.topicView.secondTopicCollectionView {
            return lists[1].count
        } else {
            return lists[2].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topicView.firstTopicCollectionView {
            
//            print("♥️lists[0] \(self.lists[0])")
//            print("💙firstList\(self.firstList)")
            
            guard let cell = topicView.firstTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            
            let data = lists[0][indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else if collectionView == self.topicView.secondTopicCollectionView {
            guard let cell = topicView.secondTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            
            let data = lists[1][indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else {
            guard let cell = topicView.thirdTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            
            let data = lists[2][indexPath.item]
            cell.configureData(data: data)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topicView.firstTopicCollectionView {
            let data = lists[0][indexPath.item]
            let vc = PhotoDetailViewController()
            
            vc.idContents = data.id
            vc.imageURLContents = data.urls.full
            vc.imageWidthContents = data.width
            vc.imageHeightContents = data.height
            vc.postDateContents = data.postDate
            vc.userNameContents = data.user.name
            vc.userProfileImageContents = data.user.profileImage.image
            
            navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == topicView.secondTopicCollectionView {
            let data = lists[1][indexPath.item]
            let vc = PhotoDetailViewController()
            
            vc.idContents = data.id
            vc.imageURLContents = data.urls.full
            vc.imageWidthContents = data.width
            vc.imageHeightContents = data.height
            vc.postDateContents = data.postDate
            vc.userNameContents = data.user.name
            vc.userProfileImageContents = data.user.profileImage.image
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let data = lists[2][indexPath.item]
            let vc = PhotoDetailViewController()
            
            vc.idContents = data.id
            vc.imageURLContents = data.urls.full
            vc.imageWidthContents = data.width
            vc.imageHeightContents = data.height
            vc.postDateContents = data.postDate
            vc.userNameContents = data.user.name
            vc.userProfileImageContents = data.user.profileImage.image
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
