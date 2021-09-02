//
//  WeatherViewModel.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 25/08/2021.
//

import Foundation

struct WeatherViewModel {
    var sections: [Section: [AnyHashable]]
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

// MARK: - Select/unselect daily entry

extension WeatherViewModel {
    var selectedDailyEntry: DailyEntry? {
        (sections[.daily] as? [DailyEntry])?.first(where: { $0.selected })
    }

    mutating func select(dailyEntry: DailyEntry) {
        guard let index = (sections[.daily] as? [DailyEntry])?.firstIndex(of: dailyEntry) else {
            return
        }
        var mutableCopy = dailyEntry
        mutableCopy.selected = true
        update(dailyEntry: mutableCopy, at: index)
        sections[.hourly] = dailyEntry.hours
    }

    mutating func deselect(dailyEntry: DailyEntry) {
        guard let index = (sections[.daily] as? [DailyEntry])?.firstIndex(of: dailyEntry) else {
            return
        }
        var mutableCopy = dailyEntry
        mutableCopy.selected = false
        update(dailyEntry: mutableCopy, at: index)
    }

    private mutating func update(dailyEntry: DailyEntry, at index: Int) {
        var dailyEntries = sections[.daily]
        dailyEntries?.replaceSubrange(index...index, with: [dailyEntry])
        sections[.daily] = dailyEntries
    }
}
