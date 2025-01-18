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
    
    lazy var queryText = searchPhotoView.photoSearchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
    
    override func loadView() {
        view = searchPhotoView
    }
    
    // 다른 탭바에 이동했다가 왔을 때
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchPhotoView.photoCollectionView.isHidden = true
        searchPhotoView.mainLabel.text = "사진을 검색해보세요."
        searchPhotoView.photoSearchBar.text = ""
    }
    
    override func configureEssential() {
        navigationItem.title = "SEARCH PHOTO"
        searchPhotoView.photoSearchBar.delegate = self
        searchPhotoView.photoCollectionView.delegate = self
        searchPhotoView.photoCollectionView.dataSource = self
        searchPhotoView.photoCollectionView.prefetchDataSource = self
        
        searchPhotoView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        if list.isEmpty {
            searchPhotoView.photoCollectionView.isHidden = true
        }
    }
    
    @objc
    func sortButtonTapped() {
        searchPhotoView.sortButton.isSelected.toggle()
        
        if queryText.isEmpty || searchPhotoView.photoCollectionView.isHidden {
            print("이때는 통신 노노")
        } else {
            if searchPhotoView.sortButton.isSelected {
                page = 1
                callRequest(query: queryText, sort: .latest)
            } else {
                page = 1
                callRequest(query: queryText, sort: .relevant)
            }
        }
    }
    
    func callRequest(query: String, sort: RequestSort) {
        NetworkManager.shared.callSearchPhotoAPI(query: query, page: page, sort: sort) { value in
            
            if self.page == 1 {
                self.list = value.results
            } else {
                self.list.append(contentsOf: value.results)
            }
            
            if self.list.isEmpty {
                self.searchPhotoView.photoCollectionView.isHidden = true
                self.searchPhotoView.mainLabel.text = "검색결과가 없어요."
            } else {
                self.searchPhotoView.photoCollectionView.isHidden = false
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
        
        for item in indexPaths {
            if list.count - 3 == item.item {
                if list.count < maxNum {
                    page += 1
                    if searchPhotoView.sortButton.isSelected {
                        callRequest(query: queryText, sort: .latest)
                    } else {
                        callRequest(query: queryText, sort: .relevant)
                    }
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
        
        queryText = searchText.trimmingCharacters(in: .whitespaces)
        
        if queryText.count < 2 {
            showAlert(title: "검색어를 다시 확인해주세요😭", message: "검색어는 2글자 이상이어야 합니다.", button: "확인") {
                self.dismiss(animated: true)
            }
        } else {
            page = 1
            if searchPhotoView.sortButton.isSelected {
                callRequest(query: queryText, sort: .latest)
            } else {
                callRequest(query: queryText, sort: .relevant)
            }
        }
        
        view.endEditing(true)
    }
}
