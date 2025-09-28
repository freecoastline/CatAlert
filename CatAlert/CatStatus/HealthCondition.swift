//
//  HealthCondition.swift
//  CatAlert
//
//  Created by ken on 2025/9/28.
//

import Foundation
import UIKit

enum HealthCondition {
    case excellent
    case good
    case normal
    case needsAttention
    
    var color:UIColor {
        switch self {
        case .excellent:
            return .systemBlue
        case .good:
            return .systemGreen
        case .normal:
            return .systemOrange
        case .needsAttention:
            return .systemRed
        }
    }
}
