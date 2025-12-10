//
//  CatStatusViewModel.swift
//  CatAlert
//
//  Created by ken on 2025/12/5.
//

import Foundation
import Combine

@MainActor
class CatStatusViewModel: ObservableObject {
    // MARK: - Published Property
    @Published private(set) var todayActivities: [ActivityRecord] = []
    @Published private(set) var catInfo: CatSimpleInfoModel?
    @Published private(set) var taskCount: Int = 0
    @Published private(set) var isLoading:Bool = false
    @Published private(set) var errorMessage: String?
    
    // MARK: - Private Property
    private let reminderManager: ReminderManager
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(reminderManager: ReminderManager = .shared) {
        self.reminderManager = reminderManager
        setupCatInfo()
    }
    
    // MARK: - Setup
    private func setupCatInfo() {
        catInfo = CatSimpleInfoModel(name: "胡胡", age: 4.5, healthCondition: .excellent, avatarImageUrl: "IMG_7595")
        catInfo?.loadImageIfNeeded()
    }
    
    private func observeDataChanges() {
        reminderManager.$todayActivities.receive(on: DispatchQueue.main).sink { [weak self] activities in
            guard let self else { return }
            todayActivities = activities
            taskCount = activities.count
        }.store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    func markActivityCompleted(_ id: String) async {
        errorMessage = nil
        isLoading = true
        do {
            let _ = try await ReminderService.shared.updateActivityStatus(id, status: .completed, completeTime: Date())
        } catch {
            errorMessage = "完成任务失败：\(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func refresh() async {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                try await reminderManager.refreshTodayData()
            } catch {
                errorMessage = "刷新失败：\(error.localizedDescription)"
            }
        }
        isLoading = false
    }
}
