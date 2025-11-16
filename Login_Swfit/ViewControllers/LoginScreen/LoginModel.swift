//
//  LoginModel.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//


import Foundation



struct LoginRequest: Codable {
    let username: String
    let password: String
}




struct LoginResponse: Codable {
    let status: Bool
    let message: String
    let user: User?
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let token: String
}














