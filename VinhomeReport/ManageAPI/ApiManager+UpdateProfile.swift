//
//  UpdateProfile.swift
//  ManageIssue
//
//  Created by Taof on 11/6/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension ApiManager {
    func updateProfile(userProfile: User, success: @escaping () -> Void, failure: @escaping (String) -> Void){
        
        let params = [
            "Name": userProfile.name,
            "dateOfBirth": userProfile.dateOfBirth,
            "gender": userProfile.gender,
            "address": userProfile.address,
            "email": userProfile.email,
            "avatar": userProfile.avatar
        ]
        
        AF.request(ApiNameManager.shared.returnUrl(ApiNameManager.shared.updateProfile), method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: getHeaders()).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let code = json["code"].intValue
                if code == 0 {
                    success()
                }else{
                    let message = json["message"].stringValue
                    failure(message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                failure(error.localizedDescription)
            }
        }
        
    }
}
