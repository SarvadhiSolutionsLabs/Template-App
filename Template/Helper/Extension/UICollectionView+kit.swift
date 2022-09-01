//
//  UICollectionView+kit.swift
//  Template
//
//  Created by Avadh on 18/05/22.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            register(nib, forCellWithReuseIdentifier: cellName)
        } else {
            register(T.self, forCellWithReuseIdentifier: cellName)
        }
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        let cellName = String(describing: T.self)
        let cell = dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? T
        return cell
    }
    
    func setBottomScrollInset() {
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset.bottom = 20
    }
    
    func snapToNearestCell() -> Int? {
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        return closestCellIndex
    }
    
    func noDataView(_ image: UIImage? = nil, _ title: String = "", _ description: String? = "") {
        let noDataView = NoDataFoundView.fromNib() as? NoDataFoundView
        if image != nil {
            noDataView?.vwImg.isHidden = false
            noDataView?.img.tintColor = Asset.secondaryTextColor.color
            noDataView?.img.image = image?.withTintColor(Asset.secondaryTextColor.color, renderingMode: .alwaysTemplate)
        } else {
            noDataView?.vwImg.isHidden = true
        }
        
        let formattedString = NSMutableAttributedString()
            .attribute(text: title, color: Asset.secondaryTextColor.color, spacing: 0.5, lineHeight: 24)
        noDataView?.lblTitle.attributedText = formattedString
        noDataView?.lblTitle.textAlignment = .center
        if description == "" {
            noDataView?.vwDescription.isHidden = true
        } else {
            noDataView?.vwDescription.isHidden = false
            noDataView?.lblDescription.text = description
        }
        self.backgroundView = noDataView
    }
    
    func clearNoDataView() {
        self.backgroundView = nil
    }
    
    func hideRefreshControl() {
        self.refreshControl?.endRefreshing()
    }
}
