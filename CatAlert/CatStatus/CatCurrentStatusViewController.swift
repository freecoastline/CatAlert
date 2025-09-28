//
//  CatCurrentStatusViewController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/7.
//

import Foundation
import UIKit
import SnapKit


class CatCurrentStatusViewController:UIViewController {
    private lazy var headerStatusView = CatInfoHeaderView(frame: .zero)
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerStatusView)
        headerStatusView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
