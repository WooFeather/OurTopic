//
//  BaseViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        configureView()
        configureEssential()
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureEssential() { }
}
