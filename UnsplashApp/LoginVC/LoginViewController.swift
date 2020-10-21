//
//  LoginViewController.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

typealias exitClosure = (( )-> Void)

class LoginViewController: UIViewController {

    static let shared = LoginViewController()

    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupView()
        setupConstrains()

        print(UserSettings.isLoggedIn)
    }

    private func setupView() {

        view.addSubview(loginButton)

        //setupLoginButton
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(logInAction), for:.touchUpInside)

    }

    private func setupConstrains() {

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func logInAction() {

        NetworkManager.sharedManager.authorizeFromController(controller: self) { (status, error) in
            if status {
                
                print("####     authorigation done    #######")
                self.exit()

            }
        }
    }
}

extension LoginViewController: ExitViewProtocol {

    func exit() {

        DispatchQueue.main.async {
            let vc = MainTabBarController()

            vc.modalPresentationStyle = .fullScreen
            //self.navigationController?.present(vc, animated: true, completion: nil)
            self.present(vc, animated: true, completion: nil)
        }
    }
}
