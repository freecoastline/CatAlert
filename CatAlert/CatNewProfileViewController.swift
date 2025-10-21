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
    enum ProfileSection: Int, CaseIterable {
        case header
        case stats
        case bio
        case videos
    }
    
    // MARK: UI Component
    private lazy var collectionView = {
        let collection = UICollectionView()
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Setup
    private func setupUI() {
        title = "猫咪资料"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CatNewProfileViewController: UICollectionViewDelegate {

}

extension CatNewProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ProfileSection.allCases.count
    }
}
