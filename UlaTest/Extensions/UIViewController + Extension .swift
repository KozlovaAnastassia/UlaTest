//
//  UIViewController + Extension .swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

extension UIViewController {
    
    static var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.green
        indicator.isHidden = true
        return indicator
    }()
    
    static var errorLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.Errors.serviceError
        label.translatesAutoresizingMaskIntoConstraints = false
       label.numberOfLines = .zero
       label.textColor = .white
       label.isHidden = true
       return label
   }()
    
     func failureScreeen() {
         UIViewController.activityIndicator.stopAnimating()
         UIViewController.activityIndicator.isHidden = true
         UIViewController.errorLabel.isHidden = false
    }
    
     func loadingScreeen() {
         UIViewController.activityIndicator.isHidden = false
         UIViewController.activityIndicator.startAnimating()
    }
    
    func loadedScreeen() {
        UIViewController.activityIndicator.isHidden = true
        UIViewController.activityIndicator.stopAnimating()
        UIViewController.errorLabel.isHidden = true
    }
}
