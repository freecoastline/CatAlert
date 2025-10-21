//
//  CatProfileViewControllerNew.swift
//  CatAlert
//
//  Created by ken on 2025/10/19.
//

import Foundation
import UIKit

class CatProfileViewControllerNew: UIViewController {
    private lazy var scrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var contentView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
