//
//  DailyEntry.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 01/09/2021.
//

import Foundation

struct DailyEntry: Hashable {
    let name: String
    let icon: WeatherIcon
    let minTemp: String
    let maxTemp: String
    let hours: [HourlyEntry]
    var selected: Bool
}
