//
//  ImageCache.swift
//  
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()

    private var cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        // Compress the image to JPEG with the specified quality
        guard let compressedData = image.jpegData(compressionQuality: 0.3),
              let compressedImage = UIImage(data: compressedData) else {
            return
        }

        let cost = compressedData.count
        cache.setObject(compressedImage, forKey: url as NSURL, cost: cost)
    }
}
