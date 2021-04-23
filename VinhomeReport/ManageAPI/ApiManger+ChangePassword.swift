//
//  ApiManger+ChangePassword.swift
//  VinhomeReport
//
//  Created by Taof on 12/9/20.
//

import Foundation
import Alamofire
import SwiftyJSON

extension ApiManager {
    func changePassword(oldPassword: String, newPassword: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        let params = [
            "NewPassword": newPassword,
            "OldPassword": oldPassword
        ]
        
        AF.request(ApiNameManager.shared.returnUrl(ApiNameManager.shared.changePassword), method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: getHeaders()).responseJSON { (response) in
            print(response)
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let code = json["code"].intValue
                
                if code == 0{
                    if json["data"].boolValue {
                        let userDefault = UserDefaults.standard
                        userDefault.setValue(newPassword, forKey: "password")
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
