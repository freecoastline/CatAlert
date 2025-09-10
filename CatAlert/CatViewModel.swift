//
//  CatViewModel.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation

class CatViewModel {
    let model = CatModel(name: "HUHU", gendre: "girl", kind: "British short", description: "fat", bornWay: "breed")
    
    func name() -> String {
        model.name
    }
}
