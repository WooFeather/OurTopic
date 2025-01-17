//
//  SearchPhotoView.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import SnapKit

class SearchPhotoView: BaseView {
    
    let photoSearchBar = UISearchBar()
    let sortButton = UIButton()
    let mainLabel = UILabel()
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(photoSearchBar)
        addSubview(sortButton)
        addSubview(mainLabel)
        addSubview(photoCollectionView)
    }
    
    override func configureLayout() {
        photoSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(14)
            make.height.equalTo(30)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(21)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(4)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        photoSearchBar.placeholder = "키워드 검색"
        
        sortButton.configuration = .sortButtonStyle()
        sortButton.layer.cornerRadius = 16
        sortButton.layer.borderColor = UIColor.lightGray.cgColor
        sortButton.layer.borderWidth = 1
        
        // 검색 결과에 따라 변경 예정
        mainLabel.text = "사진을 검색해보세요."
        mainLabel.font = .boldSystemFont(ofSize: 17)
        
        photoCollectionView.register(SearchPhotoCollectionViewCell.self, forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.id)
//        photoCollectionView.backgroundColor = .gray
    }
    
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
