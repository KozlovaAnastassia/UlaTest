//
//  UIImageView + Extension.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

extension UIImageView {
    func loadImage(withURL urlString: String, placeholder: UIImage? = nil, id: String) {
        
        guard let url = URL(string:  urlString) else {return}
        self.image = placeholder
        
        if  ImageCache.shared.getImage(forKey: id) != nil {
            self.image = ImageCache.shared.getImage(forKey: id)
            
        } else {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                ImageCache.shared.setImage(image, forKey: id)
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
