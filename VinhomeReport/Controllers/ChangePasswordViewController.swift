//
//  ChangePasswordViewController.swift
//  VinhomeReport
//
//  Created by Taof on 12/9/20.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    deinit {
        print("Huỷ AccountViewController")
    }
    
    let scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let oldPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Mật khẩu cũ"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Mật khẩu mới"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Xác nhận mật khẩu mới"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LƯU MẬT KHẨU", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.mainColor()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        addViews()
        setupLayout()
    }
    
    func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(oldPasswordTextField)
        containerView.addSubview(newPasswordTextField)
        containerView.addSubview(confirmPasswordTextField)
        containerView.addSubview(saveButton)
    }
    
    func setupLayout(){
        let margin = view.layoutMarginsGuide
        let constant: CGFloat = 20
        scrollView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        oldPasswordTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2*constant).isActive = true
        oldPasswordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2*constant).isActive = true
        oldPasswordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2*constant).isActive = true
        oldPasswordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        newPasswordTextField.topAnchor.constraint(equalTo: oldPasswordTextField.bottomAnchor, constant: constant).isActive = true
        newPasswordTextField.leadingAnchor.constraint(equalTo: oldPasswordTextField.leadingAnchor, constant: 0).isActive = true
        newPasswordTextField.trailingAnchor.constraint(equalTo: oldPasswordTextField.trailingAnchor, constant: 0).isActive = true
        newPasswordTextField.heightAnchor.constraint(equalTo: oldPasswordTextField.heightAnchor).isActive = true
        
        confirmPasswordTextField.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: constant).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor, constant: 0).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor, constant: 0).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalTo: newPasswordTextField.heightAnchor).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: constant).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor, constant: 0).isActive = true
        saveButton.heightAnchor.constraint(equalTo: confirmPasswordTextField.heightAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: confirmPasswordTextField.widthAnchor, multiplier: 1).isActive = true
        let saveButtonAnchor = saveButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -constant)
        saveButtonAnchor.priority = .defaultLow // set cho bottom có độ ưu tiên thấp
        saveButtonAnchor.isActive = true
        
    }
    
    @objc func changePassword(){
        guard let oldPassword = oldPasswordTextField.text, !oldPassword.isEmpty,
              let newPassowrd = newPasswordTextField.text, !newPassowrd.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, confirmPassword == newPassowrd else {
            AlertHelper.sorry(message: "Vui lòng nhập đầy đủ thông tin", viewController: self)
            return
        }
        
        UserDefaults.standard.removeObject(forKey: "password")
        ApiManager.shared.changePassword(oldPassword: oldPassword, newPassword: confirmPassword) {
            AlertHelper.confirmOrCancel(message: "Đổi mật khẩu thành công", viewController: self) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        } failure: { (msg) in
            AlertHelper.sorry(message: msg, viewController: self)
        }
        
    }
    
}
