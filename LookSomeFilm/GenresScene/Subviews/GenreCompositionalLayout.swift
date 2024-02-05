//
//  Проба.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 19.11.2023.
//

import Foundation
import UIKit

class GenreCompositionalLayout: UICollectionViewLayout {
    func createLayout() -> UICollectionViewLayout {
           let spacing: CGFloat = 8
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .fractionalHeight(1.0))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)

           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(300))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2) 
           group.interItemSpacing = .fixed(spacing)

           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
           section.interGroupSpacing = spacing

           let layout = UICollectionViewCompositionalLayout(section: section)
           return layout
       }
}
