//
//  CatPhotoGalleryCell.swift
//  CatAlert
//
//  Created by ken on 2025/9/23.
//

import Foundation
import UIKit

class CatPhotoGalleryCell:UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    lazy var photoCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 6
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(CatAlbumCell.self, forCellWithReuseIdentifier: "CatAlbumCell")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    
    var currentImages:[UIImage]?
    private var numberOfImages:Int {
        guard let currentImages else {
            return 0
        }
        return currentImages.count
    }
    
    
    func updateWithImages(_ images: [UIImage]) {
        currentImages = images
    }
}

extension CatPhotoGalleryCell:UICollectionViewDelegate {
    
}

extension CatPhotoGalleryCell:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatAlbumCell", for: indexPath) as? CatAlbumCell,
              let currentImages, indexPath.row < numberOfImages else {
            return UICollectionViewCell()
        }
        cell.updateWithImage(currentImages[indexPath.row])
        return cell
    }
}
