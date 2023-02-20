//
//  Coordinator.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 20/02/23.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    associatedtype CoordinatorType: Coordinator
    var coordinator: CoordinatorType { get set }
    init(coordinator: CoordinatorType)
}

protocol Coordinator: AnyObject {
    associatedtype Data
    var navigationController: UINavigationController? { get set }
    var tabBarController: UITabBarController? { get }
    var data: Data? { get set }
    
    init(navigationController: UINavigationController?)
    init(tabBarController: UITabBarController)
    func start()
    func navigate()
}

class FullBaseCoordinator<Data>: NSObject, Coordinator {
    let tabBarController: UITabBarController?
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = nil
    }
    
    var navigationController: UINavigationController?
    internal var data: Data?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.tabBarController = nil
    }
    
    func start() { }
    
    func navigate() { }
    
    func passDataToViewModel(data: Data) {
        self.data = data
    }
}

class BaseCoordinator: FullBaseCoordinator<Any> {
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        navigationController?.present(viewController, animated: animated, completion: completion)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}
