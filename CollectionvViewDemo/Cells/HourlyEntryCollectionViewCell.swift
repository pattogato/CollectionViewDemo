//
//  HourlyEntryCollectionViewCell.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit

class HourlyEntryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    func configure(with viewModel: HourlyEntry) {
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
