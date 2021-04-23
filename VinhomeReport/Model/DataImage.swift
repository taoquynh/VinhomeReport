//
//  DataImage.swift
//  VinhomeReport
//
//  Created by Taof on 11/29/20.
//

import Foundation
import SwiftyJSON

class DataImage {

    let contentType: String
    let extensionField: String
    let name: String
    let size: String
    let path: String

    required public init?(_ json: JSON) {
        contentType = json["contentType"].stringValue
        extensionField = json["extension"].stringValue
        name = json["name"].stringValue
        size = json["size"].stringValue
        path = json["path"].stringValue
    }

}
