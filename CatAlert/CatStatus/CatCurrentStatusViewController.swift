//
//  CatCurrentStatusViewController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/7.
//

import Foundation
import UIKit
import SnapKit
import Combine

class CatCurrentStatusViewController:UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private var displayedCardIds:[UUID] = []
    private lazy var headerStatusView = CatInfoHeaderView(frame: .zero)
    var catModel = CatSimpleInfoModel(name: "胡胡", age: 4.5, healthCondition: .excellent, avatarImageUrl: "IMG_7595")
    private func observeDataChange() {
        ReminderManager.shared.$todayActivities
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                loadTasks()
            }.store(in: &cancellables)
    }
    
    private func loadTasks() {
        let activities = ReminderManager.shared.todayActivities
        let activityIds = activities.map(\.id)
        
        if displayedCardIds == activityIds {
            zip(taskStackView.arrangedSubviews.compactMap({ $0 as? TaskCardView }), activities)
                .forEach { cardView, activityRecord in
                    cardView.configure(with: activityRecord)
                }
            updateBadgeCount(activities.count)
            return
        }
        
        displayedCardIds = activityIds
        
        taskStackView.arrangedSubviews.forEach { view in
            taskStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        activities.forEach { record in
            let cardView = TaskCardView()
            cardView.configure(with: record)
            cardView.onComplete = { id in
                ReminderManager.shared.markActivityCompleted(id: id)
            }
            taskStackView.addArrangedSubview(cardView)
        }
        updateBadgeCount(activities.count)
    }
    
    private func updateBadgeCount(_ count: Int) {
        guard let badge = sectionHeaderView.viewWithTag(100) as? UILabel else {
            return
        }
        badge.isHidden = count == 0
        badge.text = "(\(count))"
    }
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    //任务列表
    private lazy var taskStackView = {
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.axis = .vertical
        return stack
    }()
    
    //任务header
    private lazy var sectionHeaderView: UIView = {
         let view = UIView()

         let titleLabel = UILabel()
         titleLabel.text = "今日任务"
         titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

         let countBadge = UILabel()
         countBadge.text = "(0)"
         countBadge.font = .systemFont(ofSize: 14, weight: .medium)
         countBadge.textColor = .systemOrange
         countBadge.tag = 100 // 用于后续更新
        

         view.addSubview(titleLabel)
         view.addSubview(countBadge)

         titleLabel.snp.makeConstraints { make in
             make.left.equalToSuperview().offset(16)
             make.centerY.equalToSuperview()
         }

         countBadge.snp.makeConstraints { make in
             make.left.equalTo(titleLabel.snp.right).offset(8)
             make.centerY.equalToSuperview()
         }

         return view
     }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        catModel.loadImageIfNeeded() //预加载
        observeDataChange()
        setupUI()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        // 温暖舒适的渐变色
        gradientLayer.colors = [
            UIColor(red: 0.98, green: 0.95, blue: 0.92, alpha: 1.0).cgColor,  // 淡米色
            UIColor(red: 0.95, green: 0.92, blue: 0.95, alpha: 1.0).cgColor   // 淡紫色
        ]

        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)

        view.layoutIfNeeded()
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerStatusView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        headerStatusView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        scrollView.addSubview(sectionHeaderView)
        sectionHeaderView.snp.makeConstraints { make in
            make.top.equalTo(headerStatusView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        scrollView.addSubview(taskStackView)

        taskStackView.snp.makeConstraints { make in
            make.top.equalTo(sectionHeaderView.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
        
        headerStatusView.delegate = self
        headerStatusView.update(with: catModel)
    }
}

extension CatCurrentStatusViewController: CatInfoHeaderViewDelegate {
    func didTapAvatar() {
        if let profileVC = tabBarController?.viewControllers?.first(where: {
            $0 is CatProfileViewController
        }) {
            tabBarController?.selectedViewController = profileVC
            return
        }
    }
}
