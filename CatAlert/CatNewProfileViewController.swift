//
//  CatProfileViewControllerNew.swift
//  CatAlert
//
//  Created by ken on 2025/10/19.
//

import Foundation
import UIKit
import SnapKit

class CatNewProfileViewController: UIViewController {
    typealias Tab = ProfileActionBar.Tab
    
    // MARK: - Property
    private var lastScale: CGFloat = 1.0
    private var currentScale: CGFloat = 1.0
    private var imageViewOriginalCenter: CGPoint = .zero
    
    enum ProfileSection: Int, CaseIterable {
        case header    // 0
        case bio       // 1
        case actionBar // 2
        case videos    // 3
    }
    
    private lazy var currentTab: Tab = .album {
        didSet {
            self.collectionView.reloadSections(IndexSet(integer: ProfileSection.videos.rawValue))
        }
    }
    
    var catModel: CatSimpleInfoModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var zoomedCellFrame: CGRect = .zero
    
    private var currentTabImages: [UIImage] {
        switch currentTab {
        case .album:
            return albumImages
        case .favorite:
            return favoriteImages
        case .like:
            return likeImages
        }
    }
    
    private var currentTabMediaItems: [ProfileMediaItem] {
        switch currentTab {
        case .album:
            return albumMediaItems
        case .favorite:
            return favoriteMediaItems
        case .like:
            return likeMediaItems
        }
    }
    
    // MARK: - Test
    private var albumImages: [UIImage] = []
    private var favoriteImages: [UIImage] = []
    private var likeImages: [UIImage] = []
    private var mockPlayCounts = [62, 30, 26, 31, 27, 95]
    
    private var albumMediaItems: [ProfileMediaItem] = []
    private var favoriteMediaItems: [ProfileMediaItem] = []
    private var likeMediaItems: [ProfileMediaItem] = []
     
    // MARK: UI Component
    private lazy var collectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(ProfileHeaderCell.self, forCellWithReuseIdentifier: "ProfileHeaderCell")
        collection.register(ProfileBioCell.self, forCellWithReuseIdentifier: "ProfileBioCell")
        collection.register(ProfileVideoCell.self, forCellWithReuseIdentifier: "ProfileVideoCell")
        collection.register(ProfileActionBarCell.self, forCellWithReuseIdentifier: "ProfileActionBarCell")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var imageZoomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.9)
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private lazy var imageZoomImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        let pinGesture = UIPinchGestureRecognizer(target: self, action: #selector(handleImagePinch(_:)))
        image.addGestureRecognizer(pinGesture)
        pinGesture.delegate = self
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleImagePan(_:)))
        image.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        image.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 2
        tapGesture.delegate = self
        return image
    }()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        loadMockData()
    }
    
    // MARK: Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(imageZoomBackgroundView)
        view.addSubview(imageZoomImageView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageZoomBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageZoomBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomImageTap)))
    }
    
    private func setupNavigationBar() {
        title = "猫咪资料"
    }

    // MARK: - Data
    private func loadMockData() {
        catModel = CatSimpleInfoModel(name: "胡胡", age: 4.5, healthCondition: .excellent, avatarImageUrl: "IMG_7595")
        catModel?.loadImageIfNeeded()
        albumImages = [
            "IMG_4933",
            "IMG_5771",
            "IMG_6317",
            "IMG_6364",
            "IMG_7585",
            "IMG_7595",
            "IMG_4933",
            "IMG_5771",
            "IMG_6317",
            "IMG_6364",
            "IMG_7585",
            "IMG_7595",
            "IMG_4933",
            "IMG_5771",
            "IMG_6317",
            "IMG_6364",
            "IMG_7585",
            "IMG_7595"
        ].compactMap({ imageStr in
            ImageReader.getImage(from: imageStr, type: "JPG")
        })
        favoriteImages = Array(albumImages.prefix(6))
        likeImages = Array(albumImages.prefix(3))
        
        albumMediaItems = albumImages.enumerated().map { index, image in
            if index % 2 == 0 {
                return ProfileMediaItem.image(image, playCount: index * 10)
            } else {
                let videoURL = URL(string:"https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4")
                return ProfileMediaItem.video(thumbnail: image, videoURL: videoURL, playCount: index * 10)
            }
        }
        favoriteMediaItems = Array(favoriteMediaItems.prefix(6))
        likeMediaItems = Array(albumMediaItems.prefix(3))
    }
    
    // MARK: - Gesture
    @objc private func handleZoomImageTap() {
        dismissImageView()
    }
    
    @objc private func handleImagePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let imageView = gesture.view else {
            return
        }
        switch gesture.state {
        case .began:
            lastScale = currentScale
        case .changed:
            currentScale = min(max(0.5, gesture.scale * lastScale), 3.0)
            imageView.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        case .ended, .cancelled:
            if currentScale < 0.8 {
                dismissImageView()
            } else if currentScale < 1.0 {
                currentScale = 1.0
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                    imageView.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc private func handleImagePan(_ gesture: UIPanGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            imageViewOriginalCenter = imageView.center
        case .changed:
            let transition = gesture.translation(in: view)
            let newCenter = CGPoint(x: imageViewOriginalCenter.x + transition.x, y: imageViewOriginalCenter.y + transition.y)
            imageView.center = newCenter
            
            if currentScale <= 1.0 {
                let distance:CGFloat = sqrt(pow(transition.x, 2) + pow(transition.y, 2))
                let maxDistance: CGFloat = 200.0
                imageZoomBackgroundView.alpha = max(0.3, 1.0 - (distance / maxDistance) * 0.7)
                
                let scale = max(0.7, 1.0 - (distance / maxDistance) * 0.3)
                imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        case .ended, .cancelled:
            let transition = gesture.translation(in: view)
            let distance:CGFloat = sqrt(pow(transition.x, 2) + pow(transition.y, 2))
            
            if currentScale <= 1.0 {
                if distance > 150 {
                    dismissImageView()
                } else {
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                        [weak self] in
                        guard let self else { return }
                        imageView.center = view.center
                        imageView.transform = .identity
                        imageZoomBackgroundView.alpha = 1.0
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                    [weak self] in
                    guard let self else { return }
                    imageView.center = view.center
                }
            }
        default:
            break
        }
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        let newScale = currentScale > 1.0 ? 1.0 : 2.0
        currentScale = newScale
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            imageView.transform = CGAffineTransform(scaleX: newScale, y: newScale)
        }
    }
    
    // MARK: - Dismiss
    private func dismissImageView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            imageZoomImageView.frame = zoomedCellFrame
            imageZoomBackgroundView.alpha = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            currentScale = 1.0
            lastScale = 1.0
            imageZoomImageView.image = nil
            imageZoomBackgroundView.isHidden = true
            imageZoomImageView.transform = .identity
            imageZoomImageView.isHidden = true
        }
    }
}


// MARK: - UICollectionViewDelegate
extension CatNewProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = ProfileSection(rawValue: indexPath.section),
              section == .videos else {
            return
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProfileVideoCell else {
            return
        }
        let image = currentTabImages.count > indexPath.item ? currentTabImages[indexPath.item] : nil
        let cellframeInCollectionView = cell.frame
        let frameInView = collectionView.convert(cellframeInCollectionView, to: view)
        
        zoomedCellFrame = frameInView
        imageZoomImageView.frame = frameInView
        imageZoomImageView.image = image
        imageZoomImageView.isHidden = false
        imageZoomBackgroundView.alpha = 0
        imageZoomBackgroundView.isHidden = false
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            imageZoomImageView.frame = view.bounds
            imageZoomBackgroundView.alpha = 1
        }
    }
}


// MARK: - GestureRecognizerDelegate
extension CatNewProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
}

// MARK: - UICollectionViewDataSource
extension CatNewProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = ProfileSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 1
        case .bio:
            return 1
        case .videos:
            return currentTabImages.count
        case .actionBar:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("📱 cellForItemAt called - section: \(indexPath.section), item: \(indexPath.item)")

        guard let section = ProfileSection(rawValue: indexPath.section) else {
            print("⚠️ Unknown section: \(indexPath.section)")
            return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        }

        switch section {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderCell
            if let model = catModel {
                cell.configure(with: model)
            }
            return cell
        case .bio:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileBioCell", for: indexPath) as! ProfileBioCell
            if let model = catModel {
                cell.configure(with: model)
            }
            return cell
        case .actionBar:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileActionBarCell", for: indexPath) as! ProfileActionBarCell
            cell.configure() { [weak self] tab in
                guard let self else { return }
                currentTab = tab
            }
            return cell
        case .videos:
            print("📱 videos section - item: \(indexPath.item), currentTabImages.count: \(currentTabImages.count)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileVideoCell", for: indexPath) as! ProfileVideoCell
            let image = currentTabImages.count > indexPath.item ? currentTabImages[indexPath.item] : nil
            let playCount = mockPlayCounts.count > indexPath.item ? mockPlayCounts[indexPath.item] : 0
            cell.configure(with: image, playCount: playCount)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ProfileSection.allCases.count
    }
}


extension CatNewProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            return .zero
        }
        
        let width = collectionView.bounds.width
        switch section {
        case .header:
            return CGSize(width: width, height: 200)
        case .bio:
            return CGSize(width: width, height: 60)
        case .videos:
            let spacing:CGFloat = 2
            let totalSpacing = spacing * 2
            let itemWidth = (width - totalSpacing) / 3.0
            let itemHeight = itemWidth * 1.3
            return CGSize(width: itemWidth, height: itemHeight)
        case .actionBar:
            return CGSize(width: width, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ProfileSection(rawValue: section) == .videos ? 2.0 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        ProfileSection(rawValue: section) == .videos ? 2.0 : 0
    }
    
}
