//
//  TimePickerViewController.swift
//  CatAlert
//
//  Created by ken on 2025/10/14.
//

import UIKit

class TimePickerViewController: UIViewController {
    private var initialHour = 8
    private var initialMinite = 0
    
    private lazy var datePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
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
        
        title = "设置时间"
        
        let current = Calendar.current
        if let initialDate = current.date(bySettingHour: initialHour, minute: initialHour, second: 0, of: Date()) {
            datePicker.date = initialDate
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveTime))
        
    }
    
    @objc private func saveTime() {
        
    }
    
}
