//
//  DailyEntryCollectionViewCell.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 23/08/2021.
//

import UIKit

class DailyEntryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!

    func configure(with viewModel: DailyEntry) {
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
