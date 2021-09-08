//
//  WeatherHeaderView.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 24/08/2021.
//

import Foundation
import UIKit

final class WeatherHeaderView: UICollectionReusableView {
    private lazy var label = UILabel()
    static let sectionHeaderElementKind = "WeatherHeaderView"
    static let reuseIdentifier = "WeatherHeaderView"

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(with text: String) {
        label.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
