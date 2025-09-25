//
//  CatPhotoGalleryCell.swift
//  CatAlert
//
//  Created by ken on 2025/9/23.
//

import Foundation
import UIKit

class CatPhotoGalleryCell:UITableViewCell {
    private enum Constants {
        static let cellHeight = 200.0
        static let itemSize = CGSize(width: 130.0, height: 130.0)
        static let minimumSpacing = 36.0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.cellHeight)
        }
    }
    
    lazy var photoCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Constants.minimumSpacing
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = Constants.itemSize
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(CatAlbumCell.self, forCellWithReuseIdentifier: "CatAlbumCell")
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.isUserInteractionEnabled = true
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
        DispatchQueue.main.async { [weak self] in
            self?.photoCollectionView.reloadData()
        }
    }
}

extension CatPhotoGalleryCell:UICollectionViewDelegate {
    
}

extension CatPhotoGalleryCell:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatAlbumCell", for: indexPath)
        guard let albumCell = cell as? CatAlbumCell, let currentImages, indexPath.row < numberOfImages else {
            return cell
        }
        albumCell.updateWithImage(currentImages[indexPath.row])

        #if DEBUG
        print("📱 Cell \(indexPath.row) configured:")
        print("   - isUserInteractionEnabled: \(albumCell.isUserInteractionEnabled)")
        print("   - contentView.isUserInteractionEnabled: \(albumCell.contentView.isUserInteractionEnabled)")
        print("   - photo.isUserInteractionEnabled: \(albumCell.photo.isUserInteractionEnabled)")
        #endif

        return albumCell
    }
}


extension CatPhotoGalleryCell:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        #if DEBUG
        print("Gallery Did Scroll currentContentOffset: \(scrollView.contentOffset)")
        #endif
    }
}
