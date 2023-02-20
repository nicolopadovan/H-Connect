//
//  View.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 20/02/23.
//

import UIKit

class View<VM: CoordinatorDelegate>: UIViewController {
    var viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
