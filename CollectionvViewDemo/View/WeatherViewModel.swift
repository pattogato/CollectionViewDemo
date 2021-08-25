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
        var mutableCopy = dailyEntry
        mutableCopy.selected = true
        update(dailyEntry: mutableCopy)
        sections[.hourly] = dailyEntry.hours
    }

    mutating func deselect(dailyEntry: DailyEntry) {
        var mutableCopy = dailyEntry
        mutableCopy.selected = false
        update(dailyEntry: mutableCopy)
    }

    private mutating func update(dailyEntry: DailyEntry) {
        var dailyEntries = sections[.daily]
        guard let entryIndex = indexOf(dailyEntry: dailyEntry) else {
            return
        }

        dailyEntries?.replaceSubrange(entryIndex...entryIndex, with: [dailyEntry])
        sections[.daily] = dailyEntries
    }

    private func indexOf(dailyEntry: DailyEntry) -> Int? {
        guard let dailyEntries = sections[.daily] as? [DailyEntry] else {
            return nil
        }
        for i in 0..<dailyEntries.count {
            if dailyEntries[i].id == dailyEntry.id {
                return i
            }
        }
        return nil
    }
}
