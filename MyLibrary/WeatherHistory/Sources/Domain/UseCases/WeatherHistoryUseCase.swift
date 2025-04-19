//
//  WeatherHistoryUseCase.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import SharedModules

public class WeatherHistoryUseCase {
    private let repository: WeatherHistoryRepository

    public init(repository: WeatherHistoryRepository) {
        self.repository = repository
    }

    func getWeatherHistory(cityName: String) -> [WeatherInfo] {
        repository.getWeatherHistory(cityName: cityName)
    }

    func getCity(cityName: String) -> City? {
        repository.getCity(cityName: cityName)
    }
}
