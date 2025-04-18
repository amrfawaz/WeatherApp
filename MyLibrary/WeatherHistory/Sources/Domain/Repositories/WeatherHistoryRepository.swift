//
//  WeatherHistoryRepository.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import SharedModules

public protocol WeatherHistoryRepository {
    func getWeatherHistory(cityName: String) -> [WeatherInfo]
}
