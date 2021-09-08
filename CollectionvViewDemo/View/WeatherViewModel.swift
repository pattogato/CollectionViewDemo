//
//  WeatherViewModel.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 25/08/2021.
//

import Foundation

struct WeatherViewModel {
    struct Day: Hashable {
        let name: String
        let icon: WeatherIcon
        let minTemp: String
        let maxTemp: String
        let selected: Bool
        let id: UUID
    }
    struct Hour: Hashable {
        let time: String
        let icon: WeatherIcon
        let temperature: String
    }
    enum Item: Hashable {
        case day(Day)
        case hour(Hour)
    }
    var sections: [Section: [Item]]
    let title: String
}

enum WeatherIcon: String, CaseIterable {
    case sunny = "☀️"
    case cloudy = "☁️"
    case rainy = "🌧"
}


// MARK: - Section type

extension WeatherViewModel {
    enum Section: Int, Hashable, CaseIterable {
        case hourly
        case daily

        var order: Int {
            switch self {
            case .hourly: return 0
            case .daily: return 1
            }
        }

        var headerName: String {
            switch self {
            case .hourly:
                return "Daily weather"
            case .daily:
                return "Upcoming days"
            }
        }
    }
}
