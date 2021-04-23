//
//  SceneDelegate.swift
//  VinhomeReport
//
//  Created by Taof on 11/27/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        if !token.isEmpty {
            startMain()
        }else{
            startLogin()
        }
    }
    
    func startLogin(){
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func startMain(){
        let profileVC = HomeViewController()
        let navigationController = UINavigationController(rootViewController: profileVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

