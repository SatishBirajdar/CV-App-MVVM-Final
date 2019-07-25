//
//  UIImageView + Extension.swift
//  RickAndMortyApp
//
//  Created by Satish Birajdar on 2019-07-24.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let imageData = data as NSData? {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData as Data)
                    }
                }
            }
            task.resume()
        }
    }
}
