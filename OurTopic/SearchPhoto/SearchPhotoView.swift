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
    
    override func configureHierarchy() {
        addSubview(photoSearchBar)
        addSubview(sortButton)
        addSubview(mainLabel)
    }
    
    override func configureLayout() {
        photoSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(14)
            make.height.equalTo(30)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(21)
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
    }
}
