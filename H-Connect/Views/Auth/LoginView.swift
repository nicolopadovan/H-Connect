//
//  ViewController.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 17/02/23.
//

import UIKit

class LoginView: View<LoginViewModel> { 
    
    let emailLabel = UILabel(text: "Email", font: .systemFont(ofSize: 15, weight: .regular), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let passwordLabel = UILabel(text: "Password", font: .systemFont(ofSize: 15, weight: .regular), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let emailTextField = UITextField(placeholder: "Email")
    let passwordTextField = UITextField(placeholder: "Password")
    lazy var signInButton = UIRoundedButton(title: "Accedi", titleColor: .white, font: .systemFont(ofSize: 20, weight: .regular), backgroundColor: .blue, target: self, action: #selector(signInButton_tapped))
    
    lazy var forgotPasswordButton = UIButton(title: "Password dimenticata?", titleColor: .blue, font: .systemFont(ofSize: 14, weight: .regular), backgroundColor: .clear, target: self, action: #selector(forgotPasswordButton_tapped))
    
    lazy var signUpButton = UIButton(title: "Registrati", titleColor: .black, font: .systemFont(ofSize: 17, weight: .regular), backgroundColor: .white, target: self, action: #selector(signUpButton_tapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title  = "Accedi"
        
        view.backgroundColor = .white
        layout()
    }
    
    private func layout() {
        let stackView = view.stack(
            emailLabel,
            emailTextField.withHeight(44).withBorder(thickness: 1, color: .black, sides: [.bottom]),
            passwordLabel,
            passwordTextField.withHeight(44).withBorder(thickness: 1, color: .black, sides: [.bottom]),
            
            spacing: 5,
            alignment: .fill,
            distribution: .fill
        )
        stackView.setCustomSpacing(30, after: emailTextField)
        stackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor, bottom: nil,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        view.addSubview(signInButton)
        signInButton.anchor(top: stackView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 50))
    }
    
    @objc
    fileprivate
    func signInButton_tapped() {
        print("ViewModel", viewModel, viewModel.coordinator)
        viewModel.login(email: "test@gmail.com", password: "123456789") { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @objc
    fileprivate
    func forgotPasswordButton_tapped() {
        
    }
    
    @objc
    fileprivate
    func signUpButton_tapped() {
        
    }
    
    
}

