//
//  RandomPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import UIKit

class RandomPhotoViewController: BaseViewController {

    var randomPhotoView = RandomPhotoView()
    
    override func loadView() {
        view = randomPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func configureEssential() {
        <#code#>
    }
}
