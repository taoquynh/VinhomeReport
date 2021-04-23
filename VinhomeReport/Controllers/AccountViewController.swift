//
//  AccountViewController.swift
//  VinhomeReport
//
//  Created by Taof on 12/8/20.
//

import UIKit

class AccountViewController: UIViewController {
    
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
//        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "add-photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.mainColor().cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let cameraImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.mainColor()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let nameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Họ & tên"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        return textField
    }()
    
    let dateOfBirthTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Ngày sinh"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        return textField
    }()
    
    let addressTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Địa chỉ"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        return textField
    }()
    
    let phoneTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Số điện thoại"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        textField.keyboardType = .numberPad
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let emailTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.mainColor()
        textField.tintColor = UIColor.mainColor() // cursor
        return textField
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LƯU", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.mainColor()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()
    
    var profile: User?
    var imagePicker: UIImagePickerController!
    var newUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        addViews()
        setupLayout()
        setupData(profile)
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        photoImageView.addGestureRecognizer(tapImage)
        cameraImageView.addGestureRecognizer(tapImage)
    }
    
    func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(cameraImageView)
        containerView.addSubview(nameTextField)
        containerView.addSubview(dateOfBirthTextField)
        containerView.addSubview(addressTextField)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(emailTextField)
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
        
        photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: constant).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1).isActive = true
        
        cameraImageView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 0).isActive = true
        cameraImageView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
        cameraImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cameraImageView.heightAnchor.constraint(equalTo: cameraImageView.widthAnchor, multiplier: 1).isActive = true

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
        
        saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: constant).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 0).isActive = true
        saveButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 1).isActive = true
        
        let saveButtonAnchor = saveButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -constant)
        saveButtonAnchor.priority = .defaultLow // set cho bottom có độ ưu tiên thấp
        saveButtonAnchor.isActive = true
        
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
    
    // MARK: - Chọn ảnh
    @objc func selectedImage(){
        let alert = UIAlertController(title: "Report App", message: "Chọn ảnh từ", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Máy ảnh", style: .default, handler: { (_) in
            self.fromCamera(self.imagePicker, target: self)
        })
        let libray = UIAlertAction(title: "Thư viện", style: .default, handler: { (_) in
            self.fromLibrary(self.imagePicker, target: self)
        })
        
        alert.addAction(camera)
        alert.addAction(libray)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func saveData(){
        guard let name = nameTextField.text,
              let date = dateOfBirthTextField.text,
              let address = addressTextField.text,
              let email = emailTextField.text,
              let profile = profile else {
            return
        }
        
        profile.name = name
        profile.dateOfBirth = date
        profile.address = address
        profile.email = email
        profile.avatar = newUrl ?? ""
        
        ApiManager.shared.updateProfile(userProfile: profile) {
            AlertHelper.sorry(message: "Cập nhật thành công", viewController: self)
        } failure: { (msg) in
            AlertHelper.sorry(message: msg, viewController: self)
        }

    }

}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("error: \(info)")
            return
        }
        
        print("Selected Image: ", selectedImage)
        ApiManager.shared.upload(image: selectedImage) { [weak self] (url) in
            guard let strongSelf = self, let path = url?.path else { return }
            print("Path: ", path)
            strongSelf.photoImageView.setImage(urlString: path)
            strongSelf.newUrl = path
        } failure: { (msg) in
            AlertHelper.sorry(message: msg, viewController: self)
        }

        dismiss(animated: true, completion: nil)
    }
}
