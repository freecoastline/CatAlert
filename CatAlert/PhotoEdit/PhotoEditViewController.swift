//
//  PhotoEditViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/31.
//

import Foundation
import UIKit

class PhotoEditViewController: UIViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupBackButton()
        setupNextButton()
        setupFilterCollectionView()
    }
    
    private func setupFilterCollectionView() {
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(130)
        }
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIConstants.PhotoEdit.navigationPadding)
            make.leading.equalToSuperview().offset(UIConstants.PhotoEdit.navigationPadding)
            make.height.width.equalTo(UIConstants.PhotoEdit.backButtonSize)
        }
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIConstants.PhotoEdit.navigationPadding)
            make.trailing.equalToSuperview().offset(-UIConstants.PhotoEdit.navigationPadding)
        }
    }
    
    // MARK: - Properties
    private let originalImage: UIImage
    private lazy var ciContext = CIContext()
    private let filters = PhotoFilter.allCases
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(image: originalImage)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        return iv
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstants.PhotoEdit.nextButtonFontSize, weight: .semibold)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 110)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    init(originalImage: UIImage) {
        self.originalImage = originalImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        
    }
    
    // MARK: - Filter Application
    private func applyFilter(_ filter: PhotoFilter, to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        guard let filterName = filter.ciFilterName else {
            return image
        }
        
        guard let ciFilter = CIFilter(name: filterName) else {
            return nil
        }
        
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        if filter == .vivid {
            ciFilter.setValue(1.5, forKey: kCIInputSaturationKey)
        }
        
        guard let outputImage = ciFilter.outputImage else {
            return nil
        }
        
        guard let cgImage = ciContext.createCGImage(ciImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
}

extension PhotoEditViewController: UICollectionViewDelegate {
    
}

extension PhotoEditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else {
            return UICollectionViewCell()
        }
        
        let filter = filters[indexPath.item]
        cell.configure(with: originalImage, filterName: filter.filterName, isSelected: false)
        return cell
    }
}
