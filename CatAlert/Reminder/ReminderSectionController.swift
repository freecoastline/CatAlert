//
//  ReminderSectionController.swift
//  CatAlert
//
//  Created by ken on 2025/12/12.
//

import Foundation
import IGListKit

final class ReminderSectionController: ListSectionController {
    // MARK: - Properties
    private var reminderItem: ReminderItemModel?
    var onToggle: ((String, Bool) async -> Void)?
    
    // MARK: - LifeCycle
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
    }
    
    // MARK: - IGList Methods
    override func didUpdate(to object: Any) {
        reminderItem = object as? ReminderItemModel
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return .zero
        }
        
        let width = collectionContext.containerSize.width
        return CGSize(width: width, height: 80.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext.dequeueReusableCell(of: ReminderCell.self, for: self, at: index) as? ReminderCell, let reminderItem = reminderItem else {
            return UICollectionViewCell()
        }
        cell.onToggle = onToggle
        cell.configure(with: reminderItem.reminder)
        return cell
    }
}
