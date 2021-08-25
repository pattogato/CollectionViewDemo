//
//  WeatherData.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 24/08/2021.
//

import Foundation

enum WeatherData {
    static let sample: [DailyEntry] = (0...20).map({
        DailyEntry(
            name: Constants.days[$0 % 6],
            icon: .random(),
            minTemp: "\(Int.random(in: 12...18))°",
            maxTemp: "\(Int.random(in: 19...34))°",
            hours: makeRandomHourEntriesForADay(),
            selected: $0 == 0
        )
    })

    private static func makeRandomHourEntriesForADay() -> [HourlyEntry] {
        (6...20).map({
            HourlyEntry(
                time: "\($0):00",
                icon: .random(),
                temperature: "\(Int.random(in: 12...34))°"
            )
        })
    }
}

extension WeatherViewModel {
    init(days: [DailyEntry]) {
        self.init(sections: [
            .daily: days,
            .hourly: days.first!.hours
        ],
        title: "London"
        )
    }
}

enum Constants {
    static let days: [String] = [
        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ]
}
