//
//  ViewController.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit



class WeatherViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var dataSource = WeatherCollectionViewDataSource(collectionView: collectionView)
    private var viewModel: WeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        self.configure(with: WeatherViewModel(days: WeatherData.sample))
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(WeatherCollectionViewLayout(), animated: false)
        collectionView.register(
            WeatherHeaderView.self,
            forSupplementaryViewOfKind: WeatherHeaderView.sectionHeaderElementKind,
            withReuseIdentifier: WeatherHeaderView.reuseIdentifier
        )
    }
}

// MARK: - Data handling

extension WeatherViewController {
    func configure(with viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        title = viewModel.title
        reloadData()
    }

    private func makeSnapshot() -> NSDiffableDataSourceSnapshot<WeatherViewModel.Section, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<WeatherViewModel.Section, AnyHashable>()

        viewModel?.sections.sorted(by: { $0.key.order < $1.key.order }).forEach { section, items in
            snapshot.appendSections([section])
            snapshot.appendItems(items, toSection: section)
        }

        return snapshot
    }

    private func reloadData() {
        dataSource.apply(makeSnapshot(), animatingDifferences: true)
    }
}

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let item = dataSource.itemIdentifier(for: indexPath) as? DailyEntry,
            !item.selected
        else { return }

        if let previousItem = viewModel?.selectedDailyEntry {
            viewModel?.deselect(dailyEntry: previousItem)
        }
        viewModel?.select(dailyEntry: item)
        reloadData()
    }
}

enum WeatherIcon: String, CaseIterable {
    case sunny = "☀️"
    case cloudy = "☁️"
    case rainy = "🌧"

    static func random() -> WeatherIcon {
        WeatherIcon.allCases[Int.random(in: 0...2)]
    }
}

struct DailyEntry: Hashable {
    let name: String
    let icon: WeatherIcon
    let minTemp: String
    let maxTemp: String
    let hours: [HourlyEntry]
    let id = UUID()
    var selected: Bool
}

struct HourlyEntry: Hashable {
    let time: String
    let icon: WeatherIcon
    let temperature: String
}
