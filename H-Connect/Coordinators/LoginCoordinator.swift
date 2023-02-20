//
//  LoginCoordinator.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 20/02/23.
//

import UIKit

class LoginCoordinator: BaseCoordinator {
        
    override func start() {
        let loginViewModel = LoginViewModel(coordinator: self)
        loginViewModel.coordinator = self
        let loginView = LoginView(viewModel: loginViewModel)
        navigationController?.setViewControllers([loginView], animated: false)
    }
    
    override func navigate() {
        let tabBarController = UITabBarController()
        
        let viewModel = MainViewModel(coordinator: MainCoordinator(tabBarController: tabBarController))
        let view = MainView(viewModel: viewModel)
        view.modalPresentationStyle = .fullScreen
        navigationController?.present(view, animated: true)
    }
}
