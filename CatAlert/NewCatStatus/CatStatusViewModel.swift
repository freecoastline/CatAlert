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
    }
    
    // MARK: - Setup
    
    
    
    
}
