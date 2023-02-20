//
//  MainCoordinator.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 20/02/23.
//

import UIKit

class MainCoordinator: FullBaseCoordinator<Profile>, UICollectionViewDelegate {
    
    override func start() {
        let viewModel = MainViewModel(coordinator: self)
        let view = MainView(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: view)
        self.navigationController = navigationController
        view.tabBarItem = UITabBarItem(title: "Home", image: .init(systemName: "person.fill"), tag: 0)
        tabBarController!.viewControllers = [navigationController]
    }
    
    override func navigate() {
        guard let navigationController = navigationController else { return }
        let coordinator = MainDetailedCoordinator(navigationController: navigationController)
        coordinator.data = data
        let viewModel = MainDetailedViewModel(coordinator: coordinator)
        let view = MainDetailedView(viewModel: viewModel)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
