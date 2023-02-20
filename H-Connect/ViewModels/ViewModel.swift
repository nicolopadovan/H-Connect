//
//  ViewModel.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 18/02/23.
//

import UIKit

class ViewModel<CoordinatorType: Coordinator>: NSObject, CoordinatorDelegate {
    required init(coordinator: CoordinatorType) {
        self.coordinator = coordinator
    }
    var coordinator: CoordinatorType
    internal var data: CoordinatorType.Data? {
        return coordinator.data
    }
}
