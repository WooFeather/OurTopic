//
//  TopicViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

class TopicViewController: BaseViewController {

    var firstList: [Topic] = []
    var secondList: [Topic] = []
    var thirdList: [Topic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
    }
    
    override func configureEssential() {
        navigationItem.title = "OUR TOPIC"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func callRequest() {
        let topicQuery = ["golden-hour", "business-work", "architecture-interior"]
        var lists = [firstList, secondList, thirdList]
        
        for i in 0..<topicQuery.count {
            NetworkManager.shared.callTopicPhotoAPI(topicId: topicQuery[i]) { value in
                lists[i] = value
            }
        }
    }
}
