//
//  MainViewModel.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 19/02/23.
//

import UIKit

class MainViewModel: ViewModel<MainCoordinator>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let datasource: [Profile] = [
        Profile(image: .placeholder, name: "Olivia"),
        Profile(image: .placeholder, name: "William"),
        Profile(image: .placeholder, name: "Isabella"),
        Profile(image: .placeholder, name: "Michael"),
        Profile(image: .placeholder, name: "Sophia"),
        Profile(image: .placeholder, name: "James"),
        Profile(image: .placeholder, name: "Emma"),
        Profile(image: .placeholder, name: "Benjamin"),
        Profile(image: .placeholder, name: "Avery"),
        Profile(image: .placeholder, name: "Ethan"),
        Profile(image: .placeholder, name: "Mia"),
        Profile(image: .placeholder, name: "Alexander"),
        Profile(image: .placeholder, name: "Charlotte"),
        Profile(image: .placeholder, name: "Lucas"),
        Profile(image: .placeholder, name: "Ava")
    ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as? MainViewCell else {
            return UICollectionViewCell()
        }
        
        let profile = datasource[indexPath.item]
        
        item.imageView.image = profile.image
        item.label.text = profile.name
        
        return item
    }
    
}

extension MainViewModel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = collectionView.frame.width / 2 - 15
        let expectedHeight = dimension + 150
        
        return CGSize(width: dimension, height: expectedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.passDataToViewModel(data: datasource[indexPath.item])
        coordinator.navigate()
    }
}
