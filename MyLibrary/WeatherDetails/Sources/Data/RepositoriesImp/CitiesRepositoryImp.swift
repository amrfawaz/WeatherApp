//
//  CitiesRepositoryImp.swift
//  
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import NetworkProvider
import SharedModules
import CoreDataManager

public class WeatherDetailsRepositoryImp: WeatherDetailsRepository {
    private let api: WeatherAPI
    private let coreDataApi: CoreDataStoreAPI

    public init(
        api: WeatherAPI,
        coreDataApi: CoreDataStoreAPI
    ) {
        self.api = api
        self.coreDataApi = coreDataApi
    }

    public func fetchWeatherDetails<T: FetchCityWeatherRequest>(request: T) async throws -> WeatherInfo {
        return try await api.fetchWeather(request: request)
    }

    public func cacheWeatherDetails(
        weatherInfo: WeatherInfo,
        cityName: String
    ) {
        coreDataApi.cacheWeather(weatherInfo: weatherInfo, cityName: cityName)
    }

    public func getWeatherDetails(cityName: String, date: String) -> WeatherInfo? {
        return coreDataApi.getWeatherDetails(cityName: cityName, date: date)
    }
}

// MARK: - Mocks
#if DEBUG
final class MockWeatherDetailsRepository: WeatherDetailsRepository {
    var result: Result<WeatherInfo, Error>?
    
    func fetchWeatherDetails<T>(request: T) async throws -> WeatherInfo where T : FetchCityWeatherRequest {
        print("Mock fetchWeatherDetails called with request: \(request)")
        switch result {
        case .success(let response)?:
            return response
        case .failure(let error)?:
            throw error
        case .none:
            fatalError("Mock result not set")
        }
    }

    public func cacheWeatherDetails(
        weatherInfo: WeatherInfo,
        cityName: String
    ) {}

    public func getWeatherDetails(
        cityName: String,
        date: String
    ) -> WeatherInfo? {
        WeatherInfo.mockedWeatherInfo.first
    }
}
#endif
