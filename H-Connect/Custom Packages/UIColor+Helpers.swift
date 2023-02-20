//
//  UIColor+Helpers.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 17/02/23.
//

import UIKit

extension UIColor {
    static public func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

