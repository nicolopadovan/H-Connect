//
//  MainDetailedViewModel.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 20/02/23.
//

import UIKit

class MainDetailedViewModel: ViewModel<MainDetailedCoordinator> {
    
    func getName() -> String {
        return data?.name ?? ""
    }
    
    func getImage() -> UIImage {
        return data?.image ?? UIImage()
    }
    
}
