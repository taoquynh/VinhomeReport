//
//  ApiNameManager.swift
//  ManageIssue
//
//  Created by Taof on 11/6/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import Foundation

class ApiNameManager {
    
    static let shared = ApiNameManager()
    
    init() {
    }
    
    let domain = "http://report.bekhoe.vn"
    
    let login = "/api/accounts/login"
    let register = "/api/accounts/Register"
    let getProfile = "/api/accounts/profile"
    let upload = "/api/upload"
    let updateProfile = "/api/accounts/update"
    let changePassword = "/api/accounts/changePassword"
    
    func returnUrl(_ nameRequest: String) -> String{
        return domain + nameRequest
    }
}
