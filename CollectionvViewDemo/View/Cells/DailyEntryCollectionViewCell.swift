//
//  DailyEntryCollectionViewCell.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit

final class DailyEntryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var iconLabel: UILabel!
    @IBOutlet private var minTempLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!

    func configure(with viewModel: WeatherViewModel.Day) {
        dayLabel.text = viewModel.name
        iconLabel.text = viewModel.icon.rawValue
        minTempLabel.text = viewModel.minTemp
        maxTempLabel.text = viewModel.maxTemp
        backgroundColor = viewModel.selected ? .systemGray3 : .systemBackground
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}
