//
//  ImageDownloadService.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import Foundation
import UIKit.UIImage

struct ImageDownloadService {

    private static var sessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.allowsCellularAccess = true
        configuration.urlCache = urlCache
        return configuration
    }

    private static var urlCache: URLCache {
        let memoryCapacity  = 20 * 1024 * 1024
        let diskCapcity = 150 * 1024 * 1024
        let downloadPath = "nirmal.MyFlickr"
        return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapcity, diskPath: downloadPath)
    }


    private var ongoingRequests: [String: URLSessionTask] = [:]
    private let urlSessionService: NetworkService
    private let cache: ImageCache

    init(with urlSessionService: NetworkService = URLSessionService(session: URLSession(configuration: ImageDownloadService.sessionConfiguration)), cache: ImageCache = PhotoImageCache.shared) {
        self.urlSessionService = urlSessionService
        self.cache = cache
    }

    /// API to fetch provenances
    /// - Parameter completion: Completion Handler
    mutating func loadImage(_ urlString: String, completion: @escaping (APIServiceResult<UIImage>) -> Void) {
        if let image = cache.image(urlString) {
            completion(APIServiceResult.result(image))
            return
        }

        let task = urlSessionService.execute(.photo(urlString)) { [cache] response in
            let result = ImageResposneParser().handleResposne(response)
            switch result {
            case.result(let image): cache.add(image, cacheKey: urlString)
            case .error: break
            }
            completion(result)
        }
        ongoingRequests[urlString] = task
    }

    mutating func cancelRequest(_ urlsString: String?) {
        guard let identifier = urlsString else { return }
        ongoingRequests[identifier]?.cancel()
        ongoingRequests.removeValue(forKey: identifier)
    }

}
