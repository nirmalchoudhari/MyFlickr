//
//  UIImageView+Image.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import UIKit

/// An ImageView subclass which loads an image from given url ascyhronously
class AsyncImageView: UIImageView  {
    private var downloadService = ImageDownloadService()
    func setImage(with urlString: String, completion: (() -> Void)? = nil) {
        downloadService.loadImage(urlString) { [weak self] result in
            switch result {
            case .result(let resultImage):
                self?.image = resultImage
            case .error(_):
                debugPrint("error downloading image")
            }
        }
    }

    func cancelLoadImage(_ urlString: String?) {
        downloadService.cancelRequest(urlString)
    }
}
