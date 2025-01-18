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
        navigationItem.title = "OUR TOPIC"
        navigationController?.navigationBar.prefersLargeTitles = true
        topicView.firstTopicCollectionView.delegate = self
        topicView.firstTopicCollectionView.dataSource = self
        topicView.secondTopicCollectionView.delegate = self
        topicView.secondTopicCollectionView.dataSource = self
        topicView.thirdTopicCollectionView.delegate = self
        topicView.thirdTopicCollectionView.dataSource = self
    }
    
    func callRequest() {
        let topicQuery = ["golden-hour", "business-work", "architecture-interior"]
        var lists = [firstList, secondList, thirdList]
        
//        for i in 0..<topicQuery.count {
//            NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[i]) { value in
//                lists[i] = value
//            }
//        }
        
        NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[0]) { value in
            self.firstList = value
            print(self.firstList.count)
        }
    }
}


extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let firstCell = topicView.firstTopicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
        
        let data = firstList[indexPath.item]
        firstCell.configureData(data: data)
        
        return firstCell
    }
    
    
}
