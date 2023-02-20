//
//  MainViewCell.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 19/02/23.
//

import UIKit

class MainViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let label = UILabel(text: "SomeText", font: .systemFont(ofSize: 18, weight: .regular), textColor: .black, textAlignment: .left, numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: label.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        imageView.constrainHeight(imageView.widthAnchor)
        label.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
