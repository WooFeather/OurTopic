//
//  SearchPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import SnapKit

class SearchPhotoViewController: BaseViewController {

    let photoSearchBar = UISearchBar()
    let sortButton = UIButton()
    let mainLabel = UILabel()
    
    override func configureHierarchy() {
        view.addSubview(photoSearchBar)
        view.addSubview(sortButton)
        view.addSubview(mainLabel)
    }
    
    override func configureLayout() {
        photoSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(10)
            make.trailing.equalTo(view).offset(14)
            make.height.equalTo(30)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(21)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "SEATCH PHOTO"
        
        photoSearchBar.placeholder = "키워드 검색"
        photoSearchBar.delegate = self
        
        sortButton.configuration = .sortButtonStyle()
        DispatchQueue.main.async {
            self.sortButton.layer.cornerRadius = self.sortButton.frame.height / 2
        }
        sortButton.layer.borderColor = UIColor.lightGray.cgColor
        sortButton.layer.borderWidth = 1
        
        // 검색 결과에 따라 변경 예정
        mainLabel.text = "사진을 검색해보세요."
        mainLabel.font = .boldSystemFont(ofSize: 17)
    }
}

extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let searchText = searchBar.text else { return }
        
        let trimmingText = searchText.trimmingCharacters(in: .whitespaces)
        
        if trimmingText.count < 2 {
            showAlert(title: "검색어를 다시 확인해주세요😭", message: "검색어는 2글자 이상이어야 합니다.", button: "확인") {
                self.dismiss(animated: true)
            }
        } else {
            // trimmingText로 검색요청
        }
        
        view.endEditing(true)
    }
}
