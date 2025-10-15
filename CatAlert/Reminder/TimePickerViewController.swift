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
    var onTimeSelected: ((Int, Int) -> Void)?
    
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
        if let initialDate = current.date(bySettingHour: initialHour, minute: initialMinite, second: 0, of: Date()) {
            datePicker.date = initialDate
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneButtonTapped))
        
    }
    
    @objc private func doneButtonTapped() {
        let datePickerDate = datePicker.date
        let current = Calendar.current
        let components = current.dateComponents([.hour, .minute], from: datePickerDate)
        onTimeSelected?(components.hour ?? 0, components.minute ?? 0)
    }
    
}
