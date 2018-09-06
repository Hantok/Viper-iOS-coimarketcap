//
//  ImageCacheLoader.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class ImageCacheLoader {
    var cache: NSCache<NSString, UIImage> = NSCache()

    func obtainImage(id: Int, completionHandler: @escaping ImageCallback) {
        if let image = self.cache.object(forKey: "\(id)" as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            MarketCapService.loadImage(id) { image in
                completionHandler(image)
            }
        }
    }
}
