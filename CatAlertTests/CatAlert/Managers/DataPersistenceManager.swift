//
//  DataPersistenceManager.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation
class DataPersistenceManager {
    
    // MARK: - 通用的保存和加载函数
    
    /// 通用保存函数 - 将任意 Codable 数组保存到指定文件
    private func saveData<T: Codable>(_ data: [T], to fileName: String) throws {
        let fileURL = getFileURL(for: fileName)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let jsonData = try encoder.encode(data)
        try jsonData.write(to: fileURL)
    }
    
    /// 通用加载函数 - 从指定文件加载任意 Codable 数组
    private func loadData<T: Codable>(_ type: T.Type, from fileName: String) throws -> [T] {
        let fileURL = getFileURL(for: fileName)
        
        // 检查文件是否存在
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return [] // 如果文件不存在，返回空数组
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let data = try Data(contentsOf: fileURL)
        let result = try decoder.decode([T].self, from: data)
        
        return result
    }
    
    // MARK: - 具体业务函数
    
    // 保存提醒数据
    func saveReminders(_ reminders: [CatReminder]) throws {
        try saveData(reminders, to: "reminders.json")
    }
    
    func loadReminders() throws -> [CatReminder] {
        return try loadData(CatReminder.self, from: "reminders.json")
    }

    // 保存活动记录
    func saveActivityRecords(_ records: [ActivityRecord]) throws {
        try saveData(records, to: "activity_records.json")
    }
    
    func loadActivityRecords() throws -> [ActivityRecord] {
        try loadData(ActivityRecord.self, from: "activity_records.json")
    }
    
    // 增量更新
    func updateReminder(_ reminder: CatReminder) throws {
        var reminders = try loadReminders()
        
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index] = reminder
        } else {
            reminders.append(reminder)
        }
        
        try saveReminders(reminders)
    }
    
    func deleteReminder(id: UUID) throws {
        var reminders = try loadReminders()
        reminders.removeAll { $0.id == id }
        try saveReminders(reminders)
    }
    
    func addActivityRecord(_ record: ActivityRecord) throws {
        var records = try loadActivityRecords()
        records.append(record)
        try saveActivityRecords(records)
    }
    
    //文件管理
    // 获取文档目录路径
    private func getDocumentsDirectory() -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let catDocDirectory = documentsPath.appendingPathComponent("CatDoc")
        
        // 确保目录存在，如果不存在则创建
        try? FileManager.default.createDirectory(at: catDocDirectory, withIntermediateDirectories: true, attributes: nil)
        
        return catDocDirectory
    }
    
    private func getFileURL(for fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
 }
