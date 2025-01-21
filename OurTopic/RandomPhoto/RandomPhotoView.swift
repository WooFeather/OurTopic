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
        addSubview(randomPhotoCollectionView)
    }
    
    override func configureLayout() {
        randomPhotoCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        randomPhotoCollectionView.register(RandomPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RandomPhotoCollectionViewCell.id)
        randomPhotoCollectionView.showsVerticalScrollIndicator = false
        randomPhotoCollectionView.isPagingEnabled = true
    }
    
    // 수정예정
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
}
