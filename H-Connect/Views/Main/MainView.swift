//
//  MainViewController.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 18/02/23.
//

import UIKit

class MainView: View<MainViewModel> {

    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Home"
        
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}
