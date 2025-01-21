//
//  TopicViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

class TopicViewController: BaseViewController {

    var topicView = TopicView()
    
    var firstList: [Topic] = []
    var secondList: [Topic] = []
    var thirdList: [Topic] = []
    
    override func loadView() {
        view = topicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
    }
    
    override func configureEssential() {
        // 처음엔 navigationTitle로 했다가, push로 이동한 뷰에서도 safeArea를 LargeTitle만큼 잡고있어서 그냥 Label로 변경했습니다.
//        navigationItem.title = "OUR TOPIC"
//        navigationController?.navigationBar.prefersLargeTitles = true
        topicView.firstTopicCollectionView.delegate = self
        topicView.firstTopicCollectionView.dataSource = self
        topicView.secondTopicCollectionView.delegate = self
        topicView.secondTopicCollectionView.dataSource = self
        topicView.thirdTopicCollectionView.delegate = self
        topicView.thirdTopicCollectionView.dataSource = self
    }
    
    func callRequest() {
        let topicQuery = ["golden-hour", "business-work", "architecture-interior"]
        
        // 이런식으로 반복문으로 하려고 했는데, reloadData 처리까지 잘 해준다고 했는데 왜 셀이 안떴을까???ㅜㅜ
//        var lists = [firstList, secondList, thirdList]
        
//        for i in 0..<topicQuery.count {
//            NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[i]) { value in
//                lists[i] = value
//            }
//        }
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[0]) { value in
            self.firstList = value
            group.leave()
        } failHandler: {
            
        }
        
        group.enter()
        NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[1]) { value in
            self.secondList = value
            group.leave()
        } failHandler: {
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[2]) { value in
            self.thirdList = value
            group.leave()
        } failHandler: {
            group.leave()
        }

        group.notify(queue: .main) {
            print("네트워크 통신 완료")
            self.topicView.firstTopicCollectionView.reloadData()
            self.topicView.secondTopicCollectionView.reloadData()
            self.topicView.thirdTopicCollectionView.reloadData()
        }
    }
}

extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topicView.firstTopicCollectionView {
            return firstList.count
        } else if collectionView == self.topicView.secondTopicCollectionView {
            return secondList.count
        } else {
            return thirdList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topicView.firstTopicCollectionView {
            guard let cell = topicView.firstTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            
            let data = firstList[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else if collectionView == self.topicView.secondTopicCollectionView {
            guard let cell = topicView.secondTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            
            let data = secondList[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else {
            guard let cell = topicView.thirdTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            
            let data = thirdList[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topicView.firstTopicCollectionView {
            let data = firstList[indexPath.item]
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
            let data = secondList[indexPath.item]
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
            let data = thirdList[indexPath.item]
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
