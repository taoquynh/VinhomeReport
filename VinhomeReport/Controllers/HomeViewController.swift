//
//  HomeViewController.swift
//  VinhomeReport
//
//  Created by Taof on 12/8/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    deinit {
        print("Huỷ HomeViewController")
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "add-photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.mainColor().cgColor
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Họ & tên"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.isUserInteractionEnabled = false
        
        return textField
    }()
    
    let dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Ngày sinh"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Địa chỉ"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Số điện thoại"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    var userProfile: User?
    // tạo một biến kiểm tra màn hình profile có phải là màn đầu tiên khi vào app hay không
    // giá trị là true thì là màn đầu tiên
    var isFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        addViews()
        setupLayout()
        
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action: #selector(onEdit))
        
        let changePasswordButton = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .done, target: self, action: #selector(changePassword))
        
        navigationItem.rightBarButtonItems = [editButton, changePasswordButton]
        
        let signoutButton = UIBarButtonItem(image: UIImage.init(systemName: "return"), style: .done, target: self, action: #selector(onLogout))
        navigationItem.leftBarButtonItem = signoutButton
        
        getProfile()
    }
    
    // gọi lại hàm lấy dữ liệu profile sau khi update
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getProfile()
    }
    
    func addViews(){
        view.addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(nameTextField)
        containerView.addSubview(dateOfBirthTextField)
        containerView.addSubview(addressTextField)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(emailTextField)
    }
    
    func setupLayout(){
        let margin = view.layoutMarginsGuide
        let constant: CGFloat = 20
        
        containerView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: constant).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 2*constant).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2*constant).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2*constant).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        dateOfBirthTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: constant).isActive = true
        dateOfBirthTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 0).isActive = true
        dateOfBirthTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 0).isActive = true
        dateOfBirthTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: constant).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: dateOfBirthTextField.leadingAnchor, constant: 0).isActive = true
        addressTextField.trailingAnchor.constraint(equalTo: dateOfBirthTextField.trailingAnchor, constant: 0).isActive = true
        addressTextField.heightAnchor.constraint(equalTo: dateOfBirthTextField.heightAnchor).isActive = true
        
        phoneTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: constant).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor, constant: 0).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: addressTextField.trailingAnchor, constant: 0).isActive = true
        phoneTextField.heightAnchor.constraint(equalTo: addressTextField.heightAnchor).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: constant).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor, constant: 0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: phoneTextField.heightAnchor).isActive = true
        
    }
    
    @objc func onLogout(){
        UserDefaults.standard.removeObject(forKey: "token")
        if isFirst {
            // Nếu chưa có màn login trước đó, thì khởi tạo và show lên màn login
            let loginVC = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        } else {
            // Nếu đã có màn login trước đó, thì quay về màn đầu tiên
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func onEdit(){
        let backItem = UIBarButtonItem()
        backItem.title = "Cập nhật hồ sơ"
        navigationItem.backBarButtonItem = backItem
        
        let editVC = AccountViewController()
        // gửi profile sang màn account để chỉnh sửa
        editVC.profile = userProfile
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc func changePassword() {
        let editVC = ChangePasswordViewController()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Đổi mật khẩu"
        navigationItem.backBarButtonItem = backItem
        AlertHelper.confirmOrCancel(message: "Bạn muốn thay đổi mật khẩu?", viewController: self) {
            self.navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    func getProfile(){
        ApiManager.shared.getProfile { [weak self] (data) in
            guard let strongSelf = self else { return }
            strongSelf.userProfile = data
            strongSelf.setupData(data)
        } failure: { (msg) in
            AlertHelper.sorry(message: msg, viewController: self)
        }
    }
    
    func setupData(_ data: User?){
        guard let data = data else { return }
        if data.avatar.isEmpty {
            photoImageView.image = UIImage(named: "add-photo")
        }else{
            photoImageView.setImage(urlString: data.avatar)
        }
        nameTextField.text = data.name
        dateOfBirthTextField.text = data.dateOfBirth
        addressTextField.text = data.address
        phoneTextField.text = data.phoneNumber
        emailTextField.text = data.email
        
    }
}
