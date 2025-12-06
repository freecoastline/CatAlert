//
//  CatStatusItem.swift
//  CatAlert
//
//  Created by ken on 2025/12/6.
//

import Foundation

enum CatStatusItem: Hashable {
    case catInfo(CatSimpleInfoModel)
    case activity(ActivityRecord)
    
}
