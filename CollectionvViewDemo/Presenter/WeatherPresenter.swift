//
//  WeatherPresenter.swift
//  CollectionvViewDemo
//
//  Created by Bence Pattogato on 08/09/2021.
//

import Foundation

protocol WeatherPresenter {
    func viewLoaded(view: WeatherView)
    func selectDay(_ day: WeatherViewModel.Day)
}

final class WeatherPresenterImpl {
    var selectedDay: DailyEntry
    private let days: [DailyEntry]
    private weak var view: WeatherView?

    init(days: [DailyEntry] = WeatherData.sample) {
        self.days = days
        self.selectedDay = days.first!
    }

    private func updateView() {
        view?.configure(
            with: WeatherViewModel(
                days: days,
                hours: selectedDay.hours,
                selectedDayId: selectedDay.id
            )
        )
    }
}

extension WeatherPresenterImpl: WeatherPresenter {
    func selectDay(_ day: WeatherViewModel.Day) {
        guard let selectedDayModel = days.first(where: { $0.id == day.id }) else {
            return
        }
        selectedDay = selectedDayModel
        updateView()
    }

    func viewLoaded(view: WeatherView) {
        self.view = view
        updateView()
    }
}

private extension WeatherViewModel {
    init(days: [DailyEntry], hours: [HourlyEntry], selectedDayId: UUID) {
        sections = [
                .daily: days.map {
                    .day(
                        Day(
                            name: $0.name,
                            icon: $0.icon,
                            minTemp: $0.minTemp,
                            maxTemp: $0.maxTemp,
                            selected: $0.id == selectedDayId,
                            id: $0.id
                        )
                    )
                },
                .hourly: hours.map {
                    .hour(
                        Hour(
                            time: $0.time,
                            icon: $0.icon,
                            temperature: $0.temperature
                        )
                    )
                }
            ]
        title = "London"
    }
}
