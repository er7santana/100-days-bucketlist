//
//  User.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 06/08/24.
//

import Foundation

struct User: Identifiable, Comparable, Codable {
    
    var id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        (lhs.firstName + lhs.lastName) < (rhs.firstName + rhs.lastName)
    }
}
