//
//  CatViewModel.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation

class CatViewModel {
    let model = CatModel(name: "HUHU", gender: "girl", kind: "British short", description: "fatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfatfat", bornWay: "Breed")

    func name() -> String {
        model.name
    }
}
