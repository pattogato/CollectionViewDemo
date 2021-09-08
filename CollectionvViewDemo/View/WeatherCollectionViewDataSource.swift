//
//  WeatherCollectionViewDataSource.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 24/08/2021.
//

import Foundation
import UIKit

final class WeatherCollectionViewDataSource: UICollectionViewDiffableDataSource<WeatherViewModel.Section, WeatherViewModel.Item> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: WeatherViewModel.Item) -> UICollectionViewCell? in
            switch item {
            case let .hour(hourEntry):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyEntryCell", for: indexPath)
                (cell as? HourlyEntryCollectionViewCell)?.configure(with: hourEntry)
                return cell
            case let .day(dayEntry):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyEntryCell", for: indexPath)
                (cell as? DailyEntryCollectionViewCell)?.configure(with: dayEntry)
                return cell
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
