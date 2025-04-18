//
//  WeatherDetailsRepository.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import SharedModules

public protocol WeatherDetailsRepository {
    func fetchWeatherDetails<T: FetchCityWeatherRequest>(request: T) async throws -> WeatherInfo
    func cacheWeatherDetails(weatherInfo: WeatherInfo, cityName: String)
    func getWeatherDetails(cityName: String, date: String) -> WeatherInfo?
}
