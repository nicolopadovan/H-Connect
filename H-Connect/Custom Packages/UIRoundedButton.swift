//
//  UIRoundedButton.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 19/02/23.
//

import UIKit

class UIRoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
        clipsToBounds = true
    }
}
