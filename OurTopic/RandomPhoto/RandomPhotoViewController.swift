//
//  RandomPhotoViewController.swift
//  OurTopic
//
//  Created by 조우현 on 1/22/25.
//

import UIKit

class RandomPhotoViewController: BaseViewController {

    var randomPhotoView = RandomPhotoView()
    var list: [PhotoDetail] = []
    
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
    
    func callRequest() {
        NetworkManager.shared.callUnsplashAPI(api: .randomPhoto, type: [PhotoDetail].self) { value in
            self.list = value
            self.randomPhotoView.randomPhotoCollectionView.reloadData()
        } failHandler: {
            print("fail!")
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
