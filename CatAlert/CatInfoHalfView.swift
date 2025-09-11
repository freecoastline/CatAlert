//
//  CatInfoHalfView.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation
import UIKit

class CatInfoHalfView: UIView {
    lazy var catStatusViewModel = CatViewModel()
    lazy var nameLabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .purple
        return label
    }()
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//
//
//    func segmentAction(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            segment = 0
//        case 1:
//            segment = 1
//        case 2:
//            segment = 2
//        default:
//            break
//        }
//        tableView.reloadData()
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell!
//
//        if indexPath.row == 0 {
//            cell = tableView.dequeueReusableCell(withIdentifier: "SegmentCell", for: indexPath as IndexPath) as UITableViewCell
//           // cell.selectionStyle = .none //if necessary
//
//            let segmentControl = cell.viewWithTag(1) as! UISegmentedControl
//            segmentControl.selectedSegmentIndex = segment
//            segmentControl.addTarget(self, action: #selector(JobReportTableViewController.segmentAction(_:)), for: .valueChanged)
//        } else {
//            switch segment {
//            case 0:
//                cell = tableView.dequeueReusableCell(withIdentifier: "CellZero", for: indexPath as IndexPath) as UITableViewCell!
//            case 1:
//                cell = tableView.dequeueReusableCell(withIdentifier: "CellOne", for: indexPath as IndexPath) as UITableViewCell!
//            case 2:
//                cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)as UITableViewCell!
//            default:
//                break
//            }
//        }
//
//        return cell
//    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        nameLabel.text = catStatusViewModel.name()
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(30)
        }
        let segmentControl = UISegmentedControl(items: ["Profiles", "Status"])
        addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        
        
        backgroundColor = .white
        layer.cornerRadius = 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
