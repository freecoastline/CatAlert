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
        let filePath = Bundle.main.path(forResource: "IMG_4933", ofType: "JPG")
        guard let filePath else {
            return
        }
        let url = URL(filePath: filePath)
        var data = Data()
        do {
            data = try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        guard let image = UIImage(data: data) else {
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
