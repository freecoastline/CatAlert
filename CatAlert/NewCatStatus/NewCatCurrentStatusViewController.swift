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
    private var cancellbles = Set<AnyCancellable>()
    
    // MARK: - UI components
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.backgroundColor = .clear
        collection.register(ActivitiCell.self, forCellWithReuseIdentifier: ActivitiCell.reuseIdentifier)
        collection.register(CatInfoCollectionCell.self, forCellWithReuseIdentifier: CatInfoCollectionCell.reuseIdentifier)
        return collection
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<CatStatusSection, CatStatusItem>?
    
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 20, trailing: 16)
        
        return section
    }
    
    private func createTasksLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        return section
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    // MARK: - Bind
    private func bindViewModel() {
        viewModel.$catInfo.receive(on: DispatchQueue.main).sink { [weak self] _ in
            guard let self else { return }
            updateSnapShot()
        }.store(in: &cancellbles)
        
        
        viewModel.$todayActivities.receive(on: DispatchQueue.main).sink { [weak self] _ in
            guard let self else { return }
            updateSnapShot()
        }.store(in: &cancellbles)
    }
    
    // MARK: - Update
    private func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<CatStatusSection, CatStatusItem>()
        
        snapShot.appendSections([.header, .tasks])
        
        if let catInfo = viewModel.catInfo {
            snapShot.appendItems([.catInfo(catInfo)], toSection: .header)
        }
        
        let activities = viewModel.todayActivities.compactMap {
            CatStatusItem.activity($0)
        }
        snapShot.appendItems(activities, toSection: .tasks)
        dataSource?.apply(snapShot, animatingDifferences: true)
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
    
    // MARK: - Configure
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .activity(let record):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivitiCell.reuseIdentifier, for: indexPath) as! ActivitiCell
                cell.configure(with: record) {[weak self] id in
                    Task {
                        await self?.viewModel.markActivityCompleted(id)
                    }
                }
                return cell
            case .catInfo(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatInfoCollectionCell.reuseIdentifier, for: indexPath) as! CatInfoCollectionCell
                cell.configure(with: model)
                cell.delegate = self
                return cell
            }
        })
    }
}

extension NewCatCurrentStatusViewController: CatInfoHeaderViewDelegate {
    func didTapAvatar() {
        let profileController = tabBarController?.viewControllers?.first { vc in
            vc is CatProfileViewController
        }
        tabBarController?.selectedViewController = profileController
    }
}
