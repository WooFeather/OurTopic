//
//  SearchPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/17/25.
//

import UIKit

final class SearchPhotoViewController: BaseViewController {
    
    private var searchPhotoView = SearchPhotoView()
    private var list: [PhotoDetail] = []
    
    private var page = 1
    private var maxNum = 0
    
    private lazy var queryText = searchPhotoView.photoSearchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
    
    override func loadView() {
        view = searchPhotoView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchPhotoView.photoSearchBar.becomeFirstResponder()
    }
    
    override func configureEssential() {
        navigationItem.title = "SEARCH PHOTO"
        searchPhotoView.photoSearchBar.delegate = self
        searchPhotoView.photoCollectionView.delegate = self
        searchPhotoView.photoCollectionView.dataSource = self
        searchPhotoView.photoCollectionView.prefetchDataSource = self
        
        searchPhotoView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        for i in 0..<searchPhotoView.buttonList.count {
            searchPhotoView.buttonList[i].tag = i
            searchPhotoView.buttonList[i].addTarget(self, action: #selector(colorFilterButtonTapped), for: .touchUpInside)
        }
        
        if list.isEmpty {
            searchPhotoView.photoCollectionView.isHidden = true
        }
    }
    
    // 한 버튼을 탭했을때 다른 버튼 isSelected를 false로 만들어주기 어떻게할까나
    @objc
    private func colorFilterButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        
        let colorButton = ColorFilter.allCases
        
        switch sender.tag {
        case 0...6:
            if queryText.isEmpty {
                print("네트워크 통신 시도 X")
            } else {
                sender.isSelected.toggle()
                if sender.isSelected {
                    callRequest(query: queryText, sort: .relevant, color: colorButton[sender.tag].urlString)
                } else {
                    callRequest(query: queryText, sort: .relevant)
                }
            }
        default:
            callRequest(query: queryText, sort: .relevant)
        }
    }
    
    @objc
    private func sortButtonTapped() {
        searchPhotoView.sortButton.isSelected.toggle()
        
        if queryText.isEmpty || searchPhotoView.photoCollectionView.isHidden {
            print("네트워크 통신 시도 X")
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
    
    private func callRequest(query: String, sort: RequestSort, color: String = "") {
        NetworkManager.shared.callUnsplashAPI(api: .searchPhoto(query: query, page: page, sort: sort, color: color), type: Photo.self) { value in
            
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
        } failHandler: { statusCode in
            let title = NetworkStatus(rawValue: statusCode)?.title ?? "정의되지 않은 ERROR"
            let message = NetworkStatus(rawValue: statusCode)?.message ?? "예상치 못한 에러입니다."
            self.showAlert(title: title, message: message, button: "닫기") {
                self.dismiss(animated: true)
            }
        }
    }
}

extension SearchPhotoViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("🔗indexPath \(indexPaths)")
        
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
                    print("❗️마지막 페이지")
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
        
        let data = list[indexPath.item]
        cell.configureData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = list[indexPath.item]
        
        let vc = PhotoDetailViewController()
        
        vc.viewModel.output.idContents.value = data.id
        vc.viewModel.output.imageURLContents.value = data.urls.full
        vc.viewModel.output.imageWidthContents.value = data.width
        vc.viewModel.output.imageHeightContents.value = data.height
        vc.viewModel.output.postDateContents.value = data.postDate
        vc.viewModel.output.userNameContents.value = data.user.name
        vc.viewModel.output.userProfileImageContents.value = data.user.profileImage.image
        
        navigationController?.pushViewController(vc, animated: true)
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
        
        searchPhotoView.photoSearchBar.resignFirstResponder()
    }
}
