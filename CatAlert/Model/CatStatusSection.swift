//
//  CatStatusSection.swift
//  CatAlert
//
//  Created by ken on 2025/12/5.
//

import Foundation

enum CatStatusSection: Int, CaseIterable {
    case header
    case tasks
    var titile: String? {
        switch self {
        case .header:
            return nil
        case .tasks:
            return "Today's Task"
        }
    }
}
