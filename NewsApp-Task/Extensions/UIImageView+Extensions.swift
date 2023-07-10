//
//  UIImageView+Extensions.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(_ url:String?) {
        
        guard let urlStr = url else {
            
            self.image = UIImage(named: "appHotNews")
            return
        }
        let wrappedUrl = URL(string: urlStr)
        self.sd_setImage(with: wrappedUrl)
    }
}
