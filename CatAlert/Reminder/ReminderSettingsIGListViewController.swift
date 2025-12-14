//
//  ReminderSettingsIGListViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/14.
//

import Foundation
import UIKit
import Combine

class ReminderSettingsIGListViewController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var allReminders: [CatReminder] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "提醒设置（IGList）"
        setupUI()
    }
    
    // MARK: - UI component
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .systemGroupedBackground
        return collection
    }()
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
    
}
