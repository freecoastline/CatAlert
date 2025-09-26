//
//  ImageReader.swift
//  CatAlert
//
//  Created by ken on 2025/9/18.
//

import Foundation
import UIKit

class ImageReader {
    class func getImage(from Resource: String, type: String) -> UIImage? {
        let filePath = Bundle.main.path(forResource: Resource, ofType: type)
        guard let filePath else {
            return nil
        }
        let url = URL(filePath: filePath)
        var data = Data()
        do {
            data = try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        guard let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
