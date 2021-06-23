//
//  ColoumnFlowLayout.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import UIKit

final class ColoumnFlowLayout: UICollectionViewFlowLayout {

    private let itemsPerRow: Int

    init(itemsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.itemsPerRow = itemsPerRow
        super.init()
        self.sectionInset = sectionInset
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        guard let collectionView  = collectionView else { return }
        let insetsAndMargin: CGFloat
        if #available(iOS 11.0, *) {
            insetsAndMargin = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(itemsPerRow - 1)
        } else {
            insetsAndMargin = sectionInset.left + sectionInset.right + minimumInteritemSpacing * CGFloat(itemsPerRow - 1)
        }
        let width = ((collectionView.bounds.width - insetsAndMargin) / CGFloat(itemsPerRow)).rounded(.down)
        itemSize = CGSize(width: width, height: width)
        footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50)
    }

    
}
