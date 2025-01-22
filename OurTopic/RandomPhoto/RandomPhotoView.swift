//
//  RandomPhotoView.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import UIKit
import SnapKit

final class RandomPhotoView: BaseView {
    
    lazy var randomPhotoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(randomPhotoCollectionView)
    }
    
    override func configureLayout() {
        randomPhotoCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-54)
        }
    }
    
    override func configureView() {
        randomPhotoCollectionView.register(RandomPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RandomPhotoCollectionViewCell.id)
        randomPhotoCollectionView.showsVerticalScrollIndicator = false
        randomPhotoCollectionView.isPagingEnabled = true
        randomPhotoCollectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 54)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
}
