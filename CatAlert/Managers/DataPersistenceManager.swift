//
//  DataPersistenceManager.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation
class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    // MARK: - 通用的保存和加载函数
    
    /// 通用保存函数 - 将任意 Codable 数组保存到指定文件
    func saveData<T: Codable>(_ data: [T], to fileName: String) throws {
        let fileURL = getFileURL(for: fileName)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let jsonData = try encoder.encode(data)
        try jsonData.write(to: fileURL)
    }
    
    /// 通用加载函数 - 从指定文件加载任意 Codable 数组
    func loadData<T: Codable>(_ type: T.Type, from fileName: String) throws -> [T] {
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
