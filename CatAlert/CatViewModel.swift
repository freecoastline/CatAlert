//
//  CatViewModel.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation
import UIKit

class CatViewModel {
    var model:CatModel?
    
    init() {
        guard let image = ImageReader.getImage(from: "IMG_6364", type: "JPG") else {
            return
        }
        let images = [image]
        model = CatModel(name: "HUHU", gender: "girl", kind: "British short", description: "fatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfat", bornWay: "Breed", images: images)
    }

    func name() -> String {
        guard let name = model?.name else {
            return "NULL"
        }
        return name
    }
}
