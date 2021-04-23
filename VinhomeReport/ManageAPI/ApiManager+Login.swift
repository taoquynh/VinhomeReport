//
//  LoginAPI.swift
//  ManageIssue
//
//  Created by Taof on 11/6/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension ApiManager {
    func login(phone: String, password: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        let params = [
            "PhoneNumber": phone,
            "Password": password
        ]
        
        AF.request(ApiNameManager.shared.returnUrl(ApiNameManager.shared.login), method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let code = json["code"].intValue

                if code == 0{
                    if let data = json["data"].dictionary, let token = data["token"]?.stringValue{
                        let userDefault = UserDefaults.standard
                        userDefault.set(token, forKey: "token")
                        userDefault.setValue(password, forKey: "password")
                        success()
                    }
                }else{
                    let message = json["message"].stringValue
                    failure(message)
                }
            case .failure(let error):
                failure(error.localizedDescription)
                failure("Lỗi: \(error.localizedDescription)")
            }
        }
    }
}
