//
//  CatDailyCareViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/19.
//

import Foundation
import UIKit

class CatDailyCareViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    lazy var dailyCareLabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .purple
        label.text = "Daily Care"
        return label
    }()
    
    
    func setupUI() {
        if let superView = view.superview {
            view.frame = superView.bounds
        }
        view.addSubview(dailyCareLabel)
        dailyCareLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        
        
        
    }
}
