//
//  CatImageCell.swift
//  CatAlert
//
//  Created by ken on 2025/9/16.
//

import Foundation
import UIKit

class CatAlbumCell:UICollectionViewCell {
    var photo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

        // 强制设置所有可能拦截触摸的属性
        isUserInteractionEnabled = false
        contentView.isUserInteractionEnabled = false

        #if DEBUG
        print("🏗️ CatAlbumCell init - frame: \(frame)")
        #endif
    }
    
    func setupUI() {
        contentView.addSubview(photo)
        photo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photo.contentMode = .scaleAspectFit
        photo.isUserInteractionEnabled = false
        backgroundColor = .gray

        #if DEBUG
        print("📱 CatAlbumCell setupUI - isUserInteractionEnabled: \(isUserInteractionEnabled)")
        print("📱 CatAlbumCell setupUI - contentView.isUserInteractionEnabled: \(contentView.isUserInteractionEnabled)")
        print("📱 CatAlbumCell setupUI - photo.isUserInteractionEnabled: \(photo.isUserInteractionEnabled)")
        #endif
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        #if DEBUG
        print("🔍 CatAlbumCell hitTest called at point: \(point)")
        #endif
        return nil
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        #if DEBUG
        print("📍 CatAlbumCell point(inside:) called at point: \(point)")
        #endif
        return false  // 告诉系统这个view不包含任何点
    }
    
    func updateWithImage(_ image:UIImage) {
        photo.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
