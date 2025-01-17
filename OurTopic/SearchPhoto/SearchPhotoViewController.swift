//
//  SearchPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

class SearchPhotoViewController: BaseViewController {
    
    var searchPhotoView = SearchPhotoView()
    
    override func loadView() {
        view = searchPhotoView
    }
    
    override func configureEssential() {
        navigationItem.title = "SEARCH PHOTO"
        searchPhotoView.photoSearchBar.delegate = self
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
