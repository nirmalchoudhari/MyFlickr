//
//  PhotosViewController.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import UIKit

private enum PhotosViewControllerConstant {
    static let reuseIdentifier = "PhotoCell"
    static let sectionInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    static let itemsPerRow: Int = 3
    static let startSearch = "Welcome to MyFlickr.\nStart searching your wish..!"
}

class PhotosViewController: UICollectionViewController {

    private lazy var viewModel = PhotosViewModel()

    private var searchController: UISearchController {
        let _searchController = UISearchController(searchResultsController: nil)
        _searchController.searchBar.delegate = self
        _searchController.searchBar.sizeToFit()
        _searchController.searchBar.placeholder = Constants.searchbarPlaceholder
        _searchController.obscuresBackgroundDuringPresentation = false
        return _searchController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = ColoumnFlowLayout(itemsPerRow: PhotosViewControllerConstant.itemsPerRow,  minimumInteritemSpacing: 12, sectionInset: PhotosViewControllerConstant.sectionInsets)
        collectionView.collectionViewLayout = flowLayout
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .always
        }

        showMesaage(PhotosViewControllerConstant.startSearch)
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.searchBar
        }
    }
}

// MARK: UICollectionViewDataSource
extension PhotosViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosViewControllerConstant.reuseIdentifier, for: indexPath) as! PhotoCell

        let photo = viewModel.photo(for: indexPath)
        cell.setup(with: photo)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfPhotos - 1 {
            guard let footer =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterRefreshView", for: indexPath) as? FooterRefreshView else {
                return
            }
            guard !footer.isAnimating, viewModel.isNextPageAvailable else {
                return
            }
            footer.startLoading()
            viewModel.loadPhotos(for: viewModel.latestSearchText, page: viewModel.latestPage + 1){ [weak self] _,_ in
                footer.stopLoading()
                self?.reloadData()
            }
        }
    }

}

private extension PhotosViewController {

    func showMesaage(_ message: String?) {
        guard let msg = message else {
            collectionView.backgroundView = nil
            return
        }
        let errorLabel = UILabel(frame: collectionView.bounds)
        errorLabel.text = msg
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        collectionView.backgroundView = errorLabel

    }

    func reloadData(_ showError: Bool = false) {
        collectionView.reloadData()
        if showError, viewModel.numberOfPhotos == 0 {
            showMesaage("Opps... We didnt find what you are searching !!!")
        }
    }
}

extension PhotosViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        guard let searchtext = searchBar.text?.trimmingCharacters(in: .whitespaces), !searchtext.isEmpty else {
            return
        }
        showMesaage(nil)
        viewModel.resetValues()
        showActivityIndicator()
        reloadData()
        viewModel.loadPhotos(for: searchtext) { [weak self] _,_  in
            self?.hideActivityIndicator()
            self?.reloadData(true)
        }
    }
}
