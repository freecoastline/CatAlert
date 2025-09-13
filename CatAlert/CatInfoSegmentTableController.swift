//
//  CatInfoSegmentTableController.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/12.
//

import Foundation
import UIKit

class CatInfoSegmentTableController:UITableViewController {
    var segment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    @objc
    func segmentChange(sender: UISegmentedControl) {
        segment = sender.selectedSegmentIndex
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CatSegmentCell", for: indexPath)
            guard let cell = cell as? CatSegmentCell else {
                return cell
            }
            cell.segmentControl.addTarget(self, action:#selector(segmentChange), for: .valueChanged)
            cell.segmentControl.selectedSegmentIndex = segment
        } else {
            switch segment {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "CatInfoCell", for: indexPath)
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "CatStatusCell", for: indexPath)
            default:
                break
            }
        }
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    
    
}
