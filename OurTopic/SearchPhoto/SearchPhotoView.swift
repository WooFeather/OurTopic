//
//  SearchPhotoView.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import SnapKit

final class SearchPhotoView: BaseView {
    
    let photoSearchBar = UISearchBar()
    let sortButton = UIButton()
    let mainLabel = UILabel()
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    var buttonList: [UIButton] = []
    
    private let buttonScrollView = UIScrollView()
    private let buttonStackView = UIStackView()
    
    override func configureHierarchy() {
        addSubview(photoSearchBar)
        addSubview(buttonScrollView)
        buttonScrollView.addSubview(buttonStackView)
        addSubview(sortButton)
        addSubview(mainLabel)
        addSubview(photoCollectionView)
    }
    
    override func configureLayout() {
        photoSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        buttonScrollView.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(35)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(buttonScrollView)
            make.leading.equalTo(buttonScrollView).offset(12)
            make.trailing.equalTo(buttonScrollView).offset(-80)
            make.height.equalTo(35)
        }
        
        buttonStackView.spacing = 10
        
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonScrollView.snp.centerY)
            make.trailing.equalToSuperview().offset(12)
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
        
        buttonScrollView.showsHorizontalScrollIndicator = false
        
        configureColorFilterButton()
        
        sortButton.configuration = .sortButtonStyle()
        sortButton.setTitle(RequestSort.relevant.rawValue, for: .normal)
        sortButton.setTitle(RequestSort.latest.rawValue, for: .selected)
        sortButton.backgroundColor = .white
        sortButton.layer.cornerRadius = 16
        sortButton.layer.shadowColor = UIColor.gray.cgColor
        sortButton.layer.shadowOpacity = 1.0
        sortButton.layer.shadowOffset = CGSize.zero
        sortButton.layer.shadowRadius = 2
        
        mainLabel.text = "사진을 검색해보세요."
        mainLabel.font = .boldSystemFont(ofSize: 17)
        
        photoCollectionView.register(SearchPhotoCollectionViewCell.self, forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.id)
        photoCollectionView.keyboardDismissMode = .onDrag
    }
    
    private func configureColorFilterButton() {
        
        let colorButton = ColorFilter.allCases
        
        for i in 0..<7 {
            buttonList.append(ColorFilterButton(title: colorButton[i].title, color: colorButton[i].color))
            buttonStackView.addArrangedSubview(buttonList[i])
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
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
