//
//  UIView+Extention.swift
//  qroadapp
//
//  Created by Rashid Karina on 25.04.2023.
//

import UIKit
extension UIView {
    @IBInspectable var cornerRaduis: CGFloat{
        get { return cornerRaduis }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
