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
        return collection
    }()
    
    // MARK: - SetupUI
    private func createLayout() -> UICollectionViewLayout {
        
    }
}
