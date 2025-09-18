//
//  CatViewModel.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation
import UIKit

class CatViewModel {
    var model = CatModel(name: "HUHU", gender: "girl", kind: "British short", description: "fatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfat", bornWay: "Breed", imagesString: ["IMG_6364", "IMG_5771", "IMG_6317", "IMG_6364"], images: [])
    
    init() {
        var images = [UIImage]()
        for imagesString in model.imagesString {
            if let image = ImageReader.getImage(from: imagesString, type: "JPG") {
                images.append(image)
            }
        }
        model.images = images
    }

    func name() -> String {
        model.name
    }
}
