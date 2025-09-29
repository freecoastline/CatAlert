//
//  CatSimpleInfoModel.swift
//  CatAlert
//
//  Created by ken on 2025/9/29.
//

import Foundation
import UIKit

struct CatSimpleInfoModel {
    let name:String
    let age:Double
    var healthCondition:HealthCondition
    var avatarImageUrl:String
    private var _avatarImage:UIImage?
    var avatarImage:UIImage {
        guard let _avatarImage else {
            return defaultImage
        }
        return _avatarImage
    }
    
    var defaultImage:UIImage {
        UIImage(systemName: "fish.circle") ?? UIImage()
    }
    
    mutating func loadImageIfNeeded() {
        guard !avatarImageUrl.isEmpty,
              let image = ImageReader.getImage(from: avatarImageUrl, type: "JPG") else {
            return
        }
        _avatarImage = image
    }
    

    init(name: String, age: Double, healthCondition: HealthCondition, avatarImageUrl: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.age = max(0, age)
        self.healthCondition = healthCondition
        self.avatarImageUrl = avatarImageUrl
    }
}
