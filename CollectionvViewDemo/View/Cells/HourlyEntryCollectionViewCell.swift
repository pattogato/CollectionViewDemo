//
//  HourlyEntryCollectionViewCell.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit

final class HourlyEntryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var hourLabel: UILabel!
    @IBOutlet private var iconLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!

    func configure(with viewModel: WeatherViewModel.Hour) {
        hourLabel.text = viewModel.time
        iconLabel.text = viewModel.icon.rawValue
        tempLabel.text = viewModel.temperature
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}
