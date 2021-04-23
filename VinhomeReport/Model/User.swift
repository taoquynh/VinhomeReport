//
//  User.swift
//  VinhomeReport
//
//  Created by Taof on 11/27/20.
//

import Foundation
import SwiftyJSON

class User {
    let id: Int
    let createdAt: String
    let createdBy: String
    let modifiedAt: String
    let modifiedBy: String
    var name: String
    var dateOfBirth: String
    var address: String
    var gender: String
    let phoneNumber: String
    var email: String
    var avatar: String
    let token: String
    
    required public init?(_ json: JSON) {
        id = json["id"].intValue
        createdAt = json["createdAt"].stringValue
        createdBy = json["createdBy"].stringValue
        modifiedAt = json["modifiedAt"].stringValue
        modifiedBy = json["modifiedBy"].stringValue
        name = json["name"].stringValue
        dateOfBirth = json["dateOfBirth"].stringValue
        address = json["address"].stringValue
        gender = json["gender"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        email = json["email"].stringValue
        avatar = json["avatar"].stringValue
        token = json["token"].stringValue
    }
}

