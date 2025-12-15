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
        setNavigationBar()
        loadData()
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
    
    private func buildListItems() -> [ListDiffable] {
        var items: [ListDiffable] = []
        let types: [CatCareType] = [.food, .play, .water]
        
        for type in types {
            let reminders = allReminders.filter{ $0.type == type }
            guard !reminders.isEmpty else {
                continue
            }
            let headerSectionViewModel = ReminderSectionHeaderModel(type: type, count: reminders.count)
            items.append(headerSectionViewModel)
            for reminder in reminders {
                let item = ReminderItemModel(reminder: reminder)
                items.append(item)
            }
        }
        
        return items
    }
    
    private func setNavigationBar() {
        let addButton = UIBarButtonItem(image: .init(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped() {
        let addVC = AddReminderViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    private func loadData() {
        Task {
            let _ = try? await ReminderManager.shared.fetchReminders()
            await MainActor.run {
                allReminders = ReminderManager.shared.activeReminders
                listAdapter.performUpdates(animated: true)
            }
        }
    }
    
    private func observeDataChange() {
        ReminderManager.shared.$activeReminders.receive(on: DispatchQueue.main).sink { [weak self] reminders in
            guard let self else { return }
            allReminders = reminders
            listAdapter.performUpdates(animated: true)
        }.store(in: &cancellables)
    }
}

extension ReminderSettingsIGListViewController: ListAdapterDataSource {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is ReminderSectionHeaderModel {
            return ReminderHeaderSectionController()
        } else if object is ReminderItemModel {
            return ReminderSectionController()
        }
        fatalError("unknow object")
    }
    
    func objects(for listAdapter: ListAdapter) -> [any ListDiffable] {
        buildListItems()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
}
