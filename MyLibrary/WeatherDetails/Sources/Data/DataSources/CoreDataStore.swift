//
//  CoreDataStore.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import SharedModules
import CoreDataManager

public protocol CoreDataStoreProtocol {
    func cacheWeather(
        weatherInfo: WeatherInfo,
        cityName: String
    )
    func getWeatherDetails(
        cityName: String,
        date: String
    )  -> WeatherInfo?
}

public class CoreDataStoreAPI: CoreDataStoreProtocol {
    public init() {}

    public func cacheWeather(
        weatherInfo: WeatherInfo,
        cityName: String
    ) {
        do {
            try CoreDataManager.shared.insertWeatherInfo(
                weatherInfo,
                for: cityName
            )
            print("WeatherInfo inserted successfully")
        } catch {
            print("Failed to insert WeatherInfo: \(error)")
        }
    }

    public func getWeatherDetails(
        cityName: String,
        date: String
    ) -> WeatherInfo? {
        do {
            return try CoreDataManager.shared.retrieveWeatherInfo(forCityName: cityName, date: date)
        } catch {
            print("Failed to insert WeatherInfo: \(error)")
            return nil
        }
    }
}

