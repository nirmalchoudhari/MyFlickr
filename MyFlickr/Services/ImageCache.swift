//
//  ImageCache.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import Foundation
import UIKit.UIImage

/// Protocol to implement Cache for Images
protocol ImageCache {
    func add(_ image: UIImage, cacheKey: String)
    func image(_ cacheKey: String) -> UIImage?
}


/// Impelemtnation of ImageCache using NSCache collection
final class PhotoImageCache: ImageCache {

    static let shared = PhotoImageCache()

    init() {
        cache.totalCostLimit = 300 * 1024 * 1024 // 300 MB max memory to evict the images
    }

    private let cache = NSCache<AnyObject, AnyObject>()

    func add(_ image: UIImage, cacheKey: String) {
        cache.setObject(image, forKey: cacheKey as NSString, cost: Int(image.byteSize))
    }

    func image(_ cacheKey: String) -> UIImage? {
        return cache.object(forKey: cacheKey as NSString) as? UIImage
    }
}

/// Return the byteSize of an image.
extension UIImage {
    var byteSize: UInt64 {
        let actualSize = CGSize(width: size.width * scale, height: size.height * scale)
        let bytesPerPixel: CGFloat = 4
        let bytesPerRow = size.width * bytesPerPixel
        return UInt64(bytesPerRow) * UInt64(actualSize.height)
    }
}
