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
    
    // MARK: - Test
    private var mockImages: [UIImage] = []
    private var mockPlayCounts = [62, 30, 26, 31, 27, 95]
    
    // MARK: UI Component
    private lazy var collectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(ProfileHeaderCell.self, forCellWithReuseIdentifier: "ProfileHeaderCell")
        collection.register(ProfileBioCell.self, forCellWithReuseIdentifier: "ProfileBioCell")
        collection.register(ProfileVideoCell.self, forCellWithReuseIdentifier: "ProfileVideoCell")
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
        mockImages = [
            "IMG_4933",
            "IMG_5771",
            "IMG_6317",
            "IMG_6364",
            "IMG_7585",
            "IMG_7595"
        ].compactMap({ imageStr in
            ImageReader.getImage(from: imageStr, type: "JPG")
        })
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileVideoCell", for: indexPath) as! ProfileVideoCell
            let image = mockImages.count > indexPath.item ? mockImages[indexPath.item] : nil
            let playCount = mockPlayCounts.count > indexPath.item ? mockPlayCounts[indexPath.item] : 0
            cell.configure(with: image, playCount: playCount)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ProfileSection.allCases.count
    }
}


extension CatNewProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            return .zero
        }
        
        let width = collectionView.bounds.width
        switch section {
        case .header:
            return CGSize(width: width, height: 200)
        case .bio:
            return CGSize(width: width, height: 60)
        case .videos:
            let spacing:CGFloat = 2
            let totalSpacing = spacing * 2
            let itemWidth = (width - totalSpacing) / 3.0
            let itemHeight = itemWidth * 1.3
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ProfileSection(rawValue: section) == .videos ? 2.0 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        ProfileSection(rawValue: section) == .videos ? 2.0 : 0
    }
    
}
