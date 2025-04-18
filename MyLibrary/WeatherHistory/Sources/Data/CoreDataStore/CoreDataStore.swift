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
    func getWeatherHistory(cityName: String)  -> [WeatherInfo]
}

public class CoreDataStoreAPI: CoreDataStoreProtocol {
    public init() {}

    public func getWeatherHistory(cityName: String) -> [WeatherInfo] {
        do {
            return try CoreDataManager.shared.retrieveWeatherInfo(forCityName: cityName)
        } catch {
            print("Failed to get weather history: \(error)")
            return []
        }
    }
}
