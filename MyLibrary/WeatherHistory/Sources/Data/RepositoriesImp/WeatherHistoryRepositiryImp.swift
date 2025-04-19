//
//  WeatherHistoryRepositiryImp.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import SharedModules
import CoreDataManager

public class WeatherHistoryRepositiryImp: WeatherHistoryRepository {
    private let coreDataApi: CoreDataStoreAPI

    public init(coreDataApi: CoreDataStoreAPI) {
        self.coreDataApi = coreDataApi
    }

    public func getWeatherHistory(cityName: String) -> [WeatherInfo] {
        coreDataApi.getWeatherHistory(cityName: cityName)
    }

    public func getCity(cityName: String) -> City? {
        coreDataApi.getCity(cityName: cityName)
    }
}
