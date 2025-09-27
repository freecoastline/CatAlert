//
//  CatDailyCareViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/19.
//

import Foundation
import UIKit

struct CareItem {
    let title: String
    let imageName: String
    let description: String
}

class CatDailyCareViewController: UIViewController {
    
    // MARK: - Properties
    private let careItems: [CareItem] = [
        CareItem(title: "Feeding", imageName: "fork.knife", description: "Track daily meals"),
        CareItem(title: "Water", imageName: "drop.fill", description: "Monitor water intake"),
        CareItem(title: "Exercise", imageName: "figure.run", description: "Log play time")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAccessibility()
    }
    
    // MARK: - UI Elements
    private lazy var dailyCareLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemPurple
        label.text = "Daily Care"
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var careCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 130)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(CatCareCell.self, forCellWithReuseIdentifier: "CatCareCell")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(dailyCareLabel)
        view.addSubview(careCollectionView)
        
        dailyCareLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        careCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dailyCareLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupAccessibility() {
        dailyCareLabel.accessibilityTraits = .header
        careCollectionView.accessibilityLabel = "Care activities"
    }
    
    // MARK: - Actions
    private func handleCareItemTap(_ careItem: CareItem) {
        let alert = UIAlertController(
            title: careItem.title,
            message: "Would you like to log this activity for your cat?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Log Activity", style: .default) { _ in
            self.logCareActivity(careItem)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func logCareActivity(_ careItem: CareItem) {
        // TODO: Implement actual logging logic
        let successAlert = UIAlertController(
            title: "Activity Logged",
            message: "\(careItem.title) has been recorded for your cat.",
            preferredStyle: .alert
        )
        
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(successAlert, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension CatDailyCareViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let careItem = careItems[indexPath.item]
        handleCareItemTap(careItem)
        
        // Add haptic feedback
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.impactOccurred()
    }
}

// MARK: - UICollectionViewDataSource
extension CatDailyCareViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return careItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCareCell", for: indexPath) as? CatCareCell else {
            assertionFailure("Failed to dequeue CatCareCell")
            return UICollectionViewCell()
        }
        
        let careItem = careItems[indexPath.item]
        cell.configure(with: careItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CatDailyCareViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40 // 20 on each side
        let availableWidth = collectionView.frame.width - padding
        let itemWidth = (availableWidth - 16) / 2 // 16 for spacing between items
        
        return CGSize(width: max(itemWidth, 140), height: 130)
    }
}
