//
//  ReadAndWriteFileContentView.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 06/08/24.
//

import SwiftUI

struct ReadAndWriteFileContentView: View {
    
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "Kristine", lastName: "Armstrong"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    
    var body: some View {
        
        Button("Read and Write") {
            do {
//            let data = try JSONEncoder().encode(users)
//                let data = Data("Test message".utf8)
//            let url = URL.documentsDirectory.appending(path: "message.txt")
//                try FileManager.write(content: "test message")
                try FileManager.write(content: users)
                let input: [User] = try FileManager.read()
                print(input)
            
//            do {
//                try data.write(to: url, options: [.atomic, .completeFileProtection])
//                let input = try String(contentsOf: url)
//                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ReadAndWriteFileContentView()
}
