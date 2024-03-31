//
//  UIView + Extension.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subViews: UIView...) {
        subViews.forEach { addSubview($0) }
    }
}
