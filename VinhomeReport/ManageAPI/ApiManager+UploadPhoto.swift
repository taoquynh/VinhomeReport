//
//  UploadFileAPI.swift
//  ManageIssue
//
//  Created by Taof on 11/6/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum MimeType: String{
    case image = "image/jpeg"
}

extension ApiManager {
    func upload(image: UIImage, success: @escaping (DataImage?)->(), failure: @escaping (String)->()){
        
        AF.upload(multipartFormData: { (form) in
            //
        }, to: "\(ApiNameManager.shared.returnUrl(ApiNameManager.shared.upload))", method: .post)
        
        AF.upload(multipartFormData: { (form) in
            form.append(image.jpegData(compressionQuality: 0.1)!, withName: "file", fileName: "name.jpg", mimeType: MimeType.image.rawValue)
        }, to: "\(ApiNameManager.shared.returnUrl(ApiNameManager.shared.upload))", method: .post, headers: getHeaders())
        .uploadProgress { (progress) in
            print("Upload progress: \(progress.fractionCompleted)")
        }
        .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let code = json["code"].intValue
                if code == 0 {
                    if let data = json["data"].dictionary{
                        let dataImage = DataImage(JSON(data))
                        success(dataImage)
                    }
                } else {
                    failure(json["message"].stringValue)
                }
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
                
                failure(error.localizedDescription)
            }
        }
    }
}
