//
//  CatInfoSegmentTableController.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/12.
//

import Foundation
import UIKit

// MARK: - Supporting Types

/// Represents the different segments available in the cat info view
enum SegmentType: Int, CaseIterable {
    case profile = 0
    case status = 1
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .status: return "Status"
        }
    }
}

/// Cell identifiers for table view cells
private enum CellIdentifier: String {
    case segment = "CatSegmentCell"
    case info = "CatInfoCell"
    case status = "CatStatusCell" 
    case album = "CatAlbumCell"
}

/// Constants for row indices in the table view
private enum RowIndex {
    static let segment = 0
    static let content = 1
    static let albumStart = 2
}

class CatInfoSegmentTableController: UITableViewController {
    
    // MARK: - Properties
    private var selectedSegment: SegmentType = .profile {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private var catModel: CatModel? {
        didSet {
            guard catModel != nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private lazy var dailyCareViewController = CatDailyCareViewController()
    
    // MARK: - Computed Properties
    private var numberOfAlbumImages: Int {
        catModel?.images.count ?? 0
    }
    
    private var totalRowsForProfile: Int {
        RowIndex.albumStart + numberOfAlbumImages
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tableView.register(CatSegmentCell.self, forCellReuseIdentifier: CellIdentifier.segment.rawValue)
        tableView.register(CatInfoCell.self, forCellReuseIdentifier: CellIdentifier.info.rawValue)
        tableView.register(CatStatusCell.self, forCellReuseIdentifier: CellIdentifier.status.rawValue)
        tableView.register(CatAlbumCell.self, forCellReuseIdentifier: CellIdentifier.album.rawValue)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Public Methods
    func updateWithModel(_ model: CatModel) {
        catModel = model
    }
    
    // MARK: - Actions
    @objc private func segmentDidChange(_ sender: UISegmentedControl) {
        guard let newSegment = SegmentType(rawValue: sender.selectedSegmentIndex) else { return }
        selectedSegment = newSegment
        
        // Deselect any selected row when switching segments
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment {
        case .profile:
            return totalRowsForProfile
        case .status:
            return 2 // Segment + Status content
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case RowIndex.segment:
            return configureSegmentCell(at: indexPath)
        case RowIndex.content:
            return configureContentCell(at: indexPath)
        default:
            return configureAlbumCell(at: indexPath)
        }
    }
    
    // MARK: - Cell Configuration
    private func configureSegmentCell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.segment.rawValue, for: indexPath) as? CatSegmentCell else {
            return UITableViewCell()
        }
        
        cell.segmentControl.removeTarget(nil, action: nil, for: .valueChanged)
        cell.segmentControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        cell.segmentControl.selectedSegmentIndex = selectedSegment.rawValue
        cell.selectionStyle = .none
        
        return cell
    }
    
    private func configureContentCell(at indexPath: IndexPath) -> UITableViewCell {
        switch selectedSegment {
        case .profile:
            return configureInfoCell(at: indexPath)
        case .status:
            return configureStatusCell(at: indexPath)
        }
    }
    
    private func configureInfoCell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.info.rawValue, for: indexPath) as? CatInfoCell,
              let catModel = catModel else {
            return UITableViewCell()
        }
        
        cell.updateWithModel(catModel)
        cell.selectionStyle = .none
        return cell
    }
    
    private func configureStatusCell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.status.rawValue, for: indexPath) as? CatStatusCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .default
        return cell
    }
    
    private func configureAlbumCell(at indexPath: IndexPath) -> UITableViewCell {
        guard selectedSegment == .profile,
              let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.album.rawValue, for: indexPath) as? CatAlbumCell,
              let images = catModel?.images else {
            return UITableViewCell()
        }
        
        let imageIndex = indexPath.row - RowIndex.albumStart
        guard imageIndex >= 0 && imageIndex < images.count else {
            return UITableViewCell()
        }
        
        cell.updateWithImage(images[imageIndex])
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        switch cell {
        case let albumCell as CatAlbumCell:
            animateAlbumCell(albumCell)
        case is CatStatusCell:
            presentDailyCareViewController()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Animation & Navigation
    private func animateAlbumCell(_ cell: CatAlbumCell) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.8,
            options: [.allowUserInteraction],
            animations: {
                cell.photo.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    cell.photo.transform = .identity
                }
            }
        )
    }
    
    private func presentDailyCareViewController() {
        present(dailyCareViewController, animated: true)
    }
}
