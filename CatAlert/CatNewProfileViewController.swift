//
//  CatProfileViewControllerNew.swift
//  CatAlert
//
//  Created by ken on 2025/10/19.
//

import Foundation
import UIKit
import SnapKit

class CatNewProfileViewController: UIViewController {
    // MARK: - Property
    enum ProfileSection: Int, CaseIterable {
        case header
        case bio
        case videos
    }
    
    var catModel: CatSimpleInfoModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UI Component
    private lazy var collectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(ProfileHeaderCell.self, forCellWithReuseIdentifier: "ProfileHeaderCell")
        collection.register(ProfileBioCell.self, forCellWithReuseIdentifier: "ProfileBioCell")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        loadMockData()
    }
    
    // MARK: Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        title = "猫咪资料"

    }

    // MARK: - Data
    private func loadMockData() {
        catModel = CatSimpleInfoModel(name: "胡胡", age: 4.5, healthCondition: .excellent, avatarImageUrl: "IMG_7595")
        catModel?.loadImageIfNeeded()
    }
    
}


// MARK: - UICollectionViewDelegate
extension CatNewProfileViewController: UICollectionViewDelegate {

}


// MARK: - UICollectionViewDataSource
extension CatNewProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = ProfileSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 1
        case .bio:
            return 1
        case .videos:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        }

        switch section {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderCell
            if let model = catModel {
                cell.configure(with: model)
            }
            return cell
        case .bio:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileBioCell", for: indexPath) as! ProfileBioCell
            if let model = catModel {
                cell.configure(with: model)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            cell.backgroundColor = indexPath.section % 2 == 0 ? .systemGray6 : .white
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ProfileSection.allCases.count
    }
}
