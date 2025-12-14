//
//  ReminderSettingsIGListViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/14.
//

import Foundation
import UIKit
import Combine
import IGListKit

class ReminderSettingsIGListViewController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var allReminders: [CatReminder] = []
    private lazy var listAdapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "提醒设置（IGList）"
        setupUI()
        setupAdapter()
    }
    
    // MARK: - UI component
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .systemGroupedBackground
        return collection
    }()
    
    // MARK: - Setup
    private func setupAdapter() {
        listAdapter.collectionView = collectionView
        listAdapter.dataSource = self
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ReminderSettingsIGListViewController: ListAdapterDataSource {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        <#code#>
    }
    
    func objects(for listAdapter: ListAdapter) -> [any ListDiffable] {
        <#code#>
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        <#code#>
    }
}
