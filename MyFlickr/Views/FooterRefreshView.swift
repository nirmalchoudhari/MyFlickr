//
//  FooterRefreshView.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import UIKit

class FooterRefreshView: UICollectionReusableView {
    @IBOutlet private var spinner:  UIActivityIndicatorView!

    var isAnimating: Bool {
        spinner.isAnimating
    }

    func startLoading() {
        spinner.startAnimating()
    }

    func stopLoading() {
        spinner.stopAnimating()
    }
}


