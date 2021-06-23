//
//  PhotoCell.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: AsyncImageView!
    var urlString: String?
    func setup(with photo: Photo?) {
        guard let photo = photo else { return }
        let urlString = photo.urlString()
        self.urlString = urlString
        imageView.setImage(with: urlString)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // This is to avoid the loading wrong image in cell till the correct one is loaded.
        imageView.cancelLoadImage(urlString)
        imageView.image = nil
    }
}
