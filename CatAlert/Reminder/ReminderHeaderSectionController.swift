//
//  ReminderHeaderSectionController.swift
//  CatAlert
//
//  Created by ken on 2025/12/13.
//

import Foundation
import IGListKit

class ReminderHeaderSectionController: ListSectionController {
    // MARK: - Property
    private var headerModel: ReminderSectionHeaderModel?
    
    // MARK: - LifeCycle
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 16, left: 16, bottom: 4, right: 16)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return .zero
        }
        let width = collectionContext.containerSize.width
        return CGSize(width: width, height: 40)
    }
    
    override func didUpdate(to object: Any) {
        headerModel = object as? ReminderSectionHeaderModel
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext.dequeueReusableCell(of: ReminderHeaderCell.self, for: self, at: index) as? ReminderHeaderCell, let headerModel else {
            return UICollectionViewCell()
        }
        cell.configure(with: headerModel)
        return cell
    }
}

