//
//  RandomPhotoView.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import UIKit
import SnapKit

class RandomPhotoView: BaseView {
    
    lazy var randomPhotoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        <#code#>
    }
    
    override func configureLayout() {
        <#code#>
    }
    
    override func configureView() {
        <#code#>
    }
    
    // 수정예정
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 0
        let cellSpacing: CGFloat = 10
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (sectionInset * 2) - (cellSpacing)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: (cellWidth / 2) * 1.5)
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        return layout
    }
}
