//
//  WeatherCollectionViewDataSource.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 24/08/2021.
//

import Foundation
import UIKit

final class WeatherCollectionViewDataSource: UICollectionViewDiffableDataSource<WeatherViewModel.Section, AnyHashable> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? in
            switch item {
            case let hourEntry as HourlyEntry:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyEntryCell", for: indexPath)
                (cell as? HourlyEntryCollectionViewCell)?.configure(with: hourEntry)
                return cell
            case let dayEntry as DailyEntry:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyEntryCell", for: indexPath)
                (cell as? DailyEntryCollectionViewCell)?.configure(with: dayEntry)
                return cell
            default:
                let sectionType = WeatherViewModel.Section.allCases[indexPath.section]
                fatalError("Not covered section and item type combination for item: \(item) with section type: \(sectionType) position: \(indexPath)")
            }
        }

        supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath)
            -> UICollectionReusableView? in

          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: WeatherHeaderView.reuseIdentifier,
            for: indexPath) as? WeatherHeaderView else {
              fatalError("Cannot create header view")
          }

            supplementaryView.configure(
                with: WeatherViewModel.Section.allCases[indexPath.section].headerName
            )
            
          return supplementaryView
        }
    }
}
