//
//  UIImageView-extension.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSString, AnyObject>()
    
    func loadImage(withUrl urlString : String, useCache cahe: Bool = true) {
        guard let url = URL(string: urlString) else { return }
        
        if cahe == true, let cachedImage = UIImageView.imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.setImageWithAnimation(image: cachedImage)
            return
        }
        
        self.image = UIImage(named: "image_holder")
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data, !data.isEmpty,
                let image = UIImage(data: data) {
                if cahe == true {
                    UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
                }
                
                DispatchQueue.main.async {
                    self.setImageWithAnimation(image: image)
                }
            }
        }).resume()
    }
    
    func savePhotoInGallery() {
        DispatchQueue.main.async {
            if let image = self.image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    
    func setImageWithAnimation(image: UIImage, animationDuration: Double = 0.3) {
        UIView.transition(with: self, duration: animationDuration, options: .transitionCrossDissolve, animations: { self.image = image }, completion: nil)
    }
}
