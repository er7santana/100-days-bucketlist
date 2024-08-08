//
//  FileManager+Extensions.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 06/08/24.
//

import Foundation

extension FileManager {
    
    static let url = URL.documentsDirectory.appending(path: "message.txt")
    static let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
    
    // String
    static func write(content: String) throws {
        let data = Data(content.utf8)
        
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
    
    static func read() throws -> String {
        return try String(contentsOf: url)
    }
    
    // Codable
    static func write<T: Codable>(content: T) throws {
        let data = try JSONEncoder().encode(content)
        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
    }
    
    static func read<T: Codable>() throws -> T {
        let data = try Data(contentsOf: savePath)
        let content = try JSONDecoder().decode(T.self, from: data)
        return content
    }
    
}
