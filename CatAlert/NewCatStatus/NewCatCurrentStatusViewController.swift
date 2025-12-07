//
//  NewCatCurrentStatusViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/4.
//

import Foundation
import UIKit
import Combine

class NewCatCurrentStatusViewController: UIViewController {
    // MARK: - Property
    private let viewModel = CatStatusViewModel()
    private let cancellbles = Set<AnyCancellable>()
    
    // MARK: - UI components
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.backgroundColor = .clear
        collection.register(ActivitiCell.self, forCellWithReuseIdentifier: ActivitiCell.identifier)
        collection.register(CatInfoCollectionCell.self, forCellWithReuseIdentifier: CatInfoCollectionCell.reuseIdentifier)
        return collection
    }()
    
    // MARK: - SetupUI
    private func createLayout() -> UICollectionViewLayout {
        
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
