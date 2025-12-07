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
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = CatStatusSection.allCases[sectionIndex]
            switch section {
            case .header:
                return createHeaderLayout()
            case .tasks:
                return createTasksLayout()
            }
        }
        return layout
    }
    
    // MARK: - Layout
    private func createHeaderLayout() -> NSCollectionLayoutSection {
        
    }
    
    private func createTasksLayout() -> NSCollectionLayoutSection {
        
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        setupGradientBackground()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.name = "backgroundGradient"  // 命名以便后续查找

        // 温暖舒适的渐变色
        gradientLayer.colors = [
            UIColor(red: 0.98, green: 0.95, blue: 0.92, alpha: 1.0).cgColor,  // 淡米色
            UIColor(red: 0.95, green: 0.92, blue: 0.95, alpha: 1.0).cgColor   // 淡紫色
        ]

        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: .zero)
    }
}
