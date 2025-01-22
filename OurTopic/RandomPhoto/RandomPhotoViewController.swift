//
//  RandomPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import UIKit

final class RandomPhotoViewController: BaseViewController {

    private var randomPhotoView = RandomPhotoView()
    private var list: [PhotoDetail] = []
    
    override func loadView() {
        view = randomPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }
    
    override func configureEssential() {
        randomPhotoView.randomPhotoCollectionView.delegate = self
        randomPhotoView.randomPhotoCollectionView.dataSource  = self
        navigationController?.navigationBar.isHidden = true
    }
    
    private func callRequest() {
        NetworkManager.shared.callUnsplashAPI(api: .randomPhoto, type: [PhotoDetail].self) { value in
            self.list = value
            self.randomPhotoView.randomPhotoCollectionView.reloadData()
        } failHandler: { statusCode in
            let title = NetworkStatus(rawValue: statusCode)?.title ?? "정의되지 않은 ERROR"
            let message = NetworkStatus(rawValue: statusCode)?.message ?? "예상치 못한 에러입니다."
            self.showAlert(title: title, message: message, button: "닫기") {
                self.dismiss(animated: true)
            }
        }
    }
}

extension RandomPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = randomPhotoView.randomPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: RandomPhotoCollectionViewCell.id, for: indexPath) as? RandomPhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = list[indexPath.item]
        
        cell.configureData(data: data)
        
        return cell
    }
}
