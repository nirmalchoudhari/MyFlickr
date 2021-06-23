//
//  PhotosViewModel.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

typealias ErrorDescription = String

class PhotosViewModel {
    private var photos: [Photo] = []
    private (set) var latestSearchText: String = ""
    private (set) var latestPage: Int = 1
    private (set) var totalPages: Int = 1

    private let urlSessionService:NetworkService

    /// Initializer
    /// - Parameter networkService: A Network service implementation
    init(networkService: NetworkService = URLSessionService()) {
        urlSessionService = networkService
    }


    /// Loads searchresults for given search keys
    /// - Parameters:
    ///   - serachKey: search key to search
    ///   - page: number of the page for which results are requested
    ///   - completion: completion handler to notify the changes are done
    func loadPhotos(for serachKey: String, page: Int = 1, completion: @escaping (([Photo]?, ErrorDescription?)->Void)) {
        guard !serachKey.isEmpty else { return }
        latestPage = page
        latestSearchText = serachKey
        APIService(with: urlSessionService).fetchSearchResult(serachKey, page: page) {[weak self] result in
            print(result)
            switch result {
            case .result(let response):
                self?.photos += response.photos.photo
                self?.totalPages = response.photos.pages
                completion(self?.photos, nil)
            case .error(let error):
                debugPrint(error)
                completion(nil, error.errorDescription)
            }

        }
    }

    var numberOfPhotos: Int {
        photos.count
    }

    var isNextPageAvailable: Bool {
        latestPage < totalPages
    }

    func photo(for indexPath: IndexPath) -> Photo? {
        return photos[indexPath.row]
    }

    /// Resets all the values form view model when user changes the search
    func resetValues() {
        photos = []
        latestSearchText = ""
        latestPage = 1
        totalPages = 1
    }
}
