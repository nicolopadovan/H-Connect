//
//  MainDetailed.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 20/02/23.
//

import UIKit

class MainDetailedView: View<MainDetailedViewModel> {
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let label = UILabel(text: "SomeText", font: .systemFont(ofSize: 18), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: label.topAnchor, trailing: view.trailingAnchor)
        imageView.constrainHeight(imageView.widthAnchor)
        
        label.anchor(top: imageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        
        imageView.image = viewModel.getImage()
        label.text = viewModel.getName()
    }
    
}
