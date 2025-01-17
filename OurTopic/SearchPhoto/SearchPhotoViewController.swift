//
//  SearchPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

class SearchPhotoViewController: BaseViewController {
    
    var searchPhotoView = SearchPhotoView()
    var list: [PhotoDetail] = []
    
    var page = 1
    var maxNum = 0
    
    override func loadView() {
        view = searchPhotoView
    }
    
    override func configureEssential() {
        navigationItem.title = "SEARCH PHOTO"
        searchPhotoView.photoSearchBar.delegate = self
        searchPhotoView.photoCollectionView.delegate = self
        searchPhotoView.photoCollectionView.dataSource = self
        searchPhotoView.photoCollectionView.prefetchDataSource = self
    }
    
    func callRequest(query: String) {
        NetworkManager.shared.callSearchPhotoAPI(query: query, page: page, sort: .relevant) { value in
            
            if self.page == 1 {
                self.list = value.results
            } else {
                self.list.append(contentsOf: value.results)
            }
            
            self.maxNum = value.totalCount
            self.searchPhotoView.photoCollectionView.reloadData()
            
            if self.page == 1 && self.list.count != 0 {
                self.searchPhotoView.photoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
        }
    }
}

extension SearchPhotoViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("🔗indexPath야 \(indexPaths)")
        var queryText = searchPhotoView.photoSearchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        for item in indexPaths {
            if list.count - 3 == item.item {
                if list.count < maxNum {
                    page += 1
                    callRequest(query: queryText)
                } else {
                    print("❗️마지막 페이지야!!")
                }
            }
        }
    }
}

extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchPhotoView.photoCollectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.id, for: indexPath) as? SearchPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let data = list[indexPath.row]
        cell.configureData(data: data)
        
        return cell
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
            page = 1
            callRequest(query: trimmingText)
        }
        
        view.endEditing(true)
    }
}
