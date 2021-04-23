//
//  File.swift
//  VinhomeReport
//
//  Created by Taof on 11/29/20.
//

import UIKit
import Photos

extension UIViewController {
    
    // MARK: - Open setting photos của hệ điều hành
    func setting(){
        let message = "App cần truy cập máy ảnh và thư viện của bạn. Ảnh của bạn sẽ không được chia sẻ khi chưa được phép của bạn."
        
        AlertHelper.confirmOrCancel(message: message, viewController: self) {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.openURL(settingsUrl)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }
    }
    
    // MARK: - Lấy ảnh từ thư viện
    func fromLibrary(_ imagePicker: UIImagePickerController, target vc: UIViewController){
        func choosePhoto(){
            DispatchQueue.main.async {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                imagePicker.modalPresentationStyle = .popover
                vc.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        // khai báo biến để lấy quyền truy cập
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            // quyền truy cập đã được cấp
            choosePhoto()
        }else if (status == PHAuthorizationStatus.denied) {
            // quyền truy cập bị từ chối
            setting()
        }else if (status == PHAuthorizationStatus.notDetermined) {
            // quyền truy cập chưa được xác nhận
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    choosePhoto()
                }else {
                    print("Không được cho phép truy cập vào thư viện ảnh")
                    DispatchQueue.main.async {
                        self.setting()
                    }
                }
            })
        }else if (status == PHAuthorizationStatus.restricted) {
            // Truy cập bị hạn chế, thông thường sẽ không xảy ra
            setting()
        }
    }
    
    // MARK: - Lấy ảnh từ camera
    func fromCamera(_ imagePicker: UIImagePickerController, target vc: UIViewController){
        func takePhoto(){
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                DispatchQueue.main.async {
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.cameraCaptureMode = .photo
                    imagePicker.cameraDevice = .front
                    imagePicker.modalPresentationStyle = .fullScreen
                    vc.present(imagePicker, animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                takePhoto()
            } else {
                print("camera denied")
                self.setting()
            }
        }
    }
}
