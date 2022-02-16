//
//  CatCollectionViewController.swift
//  Demo
//
//  Created by SHIH-YING PAN on 2019/8/4.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit
import Kingfisher

class CatCollectionViewController: UICollectionViewController {
    let orangeCatIds = [
        "595f280f557291a9750ebfb7",
        "595f2809557291a9750ebf31",
        "595f2810557291a9750ebfd7"
    ]
    let hatCatIds = [
        "6010b5cb47d128001b7bbb7c"
    ]
    let whiteCatIds = [
        "595f280c557291a9750ebf7f",
        "595f2809557291a9750ebf30"
    ]
    lazy var catSections = [orangeCatIds, hatCatIds, whiteCatIds]
    
    func configureCellSize() {
        let itemSpace: CGFloat = 3
        let columnCount: CGFloat = 2
        
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCellSize()
        collectionView.register(UINib(nibName: CollectionHeaderView.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseIdentifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyHeader")
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return catSections.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catSections[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.reuseIdentifier, for: indexPath) as! CatCollectionViewCell
        let catId = catSections[indexPath.section][indexPath.row]
        let url = URL(string: "https://cataas.com/cat/\(catId)")
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EmptyHeader", for: indexPath)
            return headerView
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.reuseIdentifier, for: indexPath) as! CollectionHeaderView
            if indexPath.section == 0 {
                headerView.textLabel.text = "橘貓"
            } else {
                headerView.textLabel.text = "白貓"
            }
            return headerView
        }
    }

}

extension CatCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
        if section == 1 {
            return .zero
        } else {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
    }
}
