//
//  TimePickerViewController.swift
//  CatAlert
//
//  Created by ken on 2025/10/14.
//

import UIKit

class TimePickerViewController: UIViewController {
    private lazy var datePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
