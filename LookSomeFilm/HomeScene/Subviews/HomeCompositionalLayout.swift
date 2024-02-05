//
//  HomeCompositionalLayout.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 21.11.2023.
//

import Foundation
import UIKit

class HomeCompositionalLayout: UICollectionViewLayout {
    func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 4
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2) // <---
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        section.orthogonalScrollingBehavior = .continuous

        let footerHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(42.0))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
                   layoutSize: footerHeaderSize,
                   elementKind: UICollectionView.elementKindSectionHeader,
                   alignment: .top)
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
