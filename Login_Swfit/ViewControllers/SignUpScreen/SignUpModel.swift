//
//  SignUpModel.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//

import Foundation

struct SignUpRequest: Codable{
    let name:String
    let email: String
    let phone: String
    let password: String
    let confirmPassword: String
}


struct SignUpResponse: Codable{
    let status:Bool
    let message:String
    let user:user?
}

struct user: Codable{
    let id:Int
    let name:String
    let email:String
    let phone:String?
    let token:String
    
}
