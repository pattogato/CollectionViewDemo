//
//  ViewController.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit

protocol WeatherView: AnyObject {
    func configure(with viewModel: WeatherViewModel)
}

class WeatherViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var dataSource = WeatherCollectionViewDataSource(collectionView: collectionView)
    private var viewModel: WeatherViewModel?
    // This is to be injected for clean code via the initialiser
    private let presenter: WeatherPresenter = WeatherPresenterImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        presenter.viewLoaded(view: self)
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

extension WeatherViewController: WeatherView {
    func configure(with viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        title = viewModel.title
        reloadData()
    }
}

// MARK: - Data handling

extension WeatherViewController {
    private func makeSnapshot() -> NSDiffableDataSourceSnapshot<WeatherViewModel.Section, WeatherViewModel.Item> {
        var snapshot = NSDiffableDataSourceSnapshot<WeatherViewModel.Section, WeatherViewModel.Item>()

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
            let item = dataSource.itemIdentifier(for: indexPath),
            case let WeatherViewModel.Item.day(day) = item
        else { return }

        presenter.selectDay(day)
    }
}
