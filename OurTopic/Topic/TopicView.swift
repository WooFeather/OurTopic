//
//  TopicView.swift
//  OurTopic
//
//  Created by 조우현 on 1/19/25.
//

import UIKit
import SnapKit

final class TopicView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let navigationLabel = UILabel()
    private let firstTopicLabel = UILabel()
    private let secondTopicLabel = UILabel()
    private let thirdTopicLabel = UILabel()
    
    lazy var firstTopicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var secondTopicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var thirdTopicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(navigationLabel)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [firstTopicLabel, secondTopicLabel, thirdTopicLabel, firstTopicCollectionView, secondTopicCollectionView, thirdTopicCollectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        navigationLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(17)
            make.height.equalTo(30)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationLabel.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        firstTopicLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(17)
            make.height.equalTo(22)
        }
        
        firstTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstTopicLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        secondTopicLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTopicCollectionView.snp.bottom).offset(12)
            make.leading.equalTo(contentView).offset(17)
            make.height.equalTo(22)
        }
        
        secondTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondTopicLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        thirdTopicLabel.snp.makeConstraints { make in
            make.top.equalTo(secondTopicCollectionView.snp.bottom).offset(12)
            make.leading.equalTo(contentView).offset(17)
            make.height.equalTo(22)
        }
        
        thirdTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(thirdTopicLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
    override func configureView() {
        navigationLabel.text = "OUR TOPIC"
        navigationLabel.font = .systemFont(ofSize: 28, weight: .bold)
        
        scrollView.showsVerticalScrollIndicator = false
        
        firstTopicLabel.text = "골든 아워"
        firstTopicLabel.font = .systemFont(ofSize: 19, weight: .heavy)
        
        firstTopicCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        firstTopicCollectionView.showsHorizontalScrollIndicator = false
        
        secondTopicLabel.text = "비즈니스 및 업무"
        secondTopicLabel.font = .systemFont(ofSize: 19, weight: .heavy)
        
        secondTopicCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        secondTopicCollectionView.showsHorizontalScrollIndicator = false
        
        thirdTopicLabel.text = "건축 및 인테리어"
        thirdTopicLabel.font = .systemFont(ofSize: 19, weight: .heavy)
        
        thirdTopicCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        thirdTopicCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 17
        let cellSpacing: CGFloat = 4
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.minimumInteritemSpacing = cellSpacing
        return layout
    }
}
