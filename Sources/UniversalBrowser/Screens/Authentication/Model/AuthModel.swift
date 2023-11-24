//
//  UserAuthStatus.swift
//  UniversalBrowserDemo
//
//  Created by BJIT on 11/10/23.
//

import Foundation

struct AuthModel: Codable {
    let status: String
    let token: String?
    let user: User?
    let validity: Int?
}


struct User: Codable {
    let email, name: String
}
