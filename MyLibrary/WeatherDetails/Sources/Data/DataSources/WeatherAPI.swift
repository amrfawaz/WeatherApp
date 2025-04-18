//
//  WeatherAPI.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import EnvironmentVariables
import NetworkProvider
import SharedModules
import CoreDataManager

public protocol WeatherAPIProtocol {
    func fetchWeather(request: FetchCityWeatherRequest) async throws -> WeatherInfo
    func cacheWeather(
        weatherInfo: WeatherInfo,
        cityName: String
    )
}

public class WeatherAPI: WeatherAPIProtocol {
    private let networkManager: NetworkProvider
    private let urlSession = URLSession.shared

    public init(networkManager: NetworkProvider = NetworkProvider()) {
        self.networkManager = networkManager
    }

    public func fetchWeather(request: FetchCityWeatherRequest) async throws -> WeatherInfo {
        guard let urlRequest = request.request else { throw NetworkError.invalidRequest }

        do {
            var response = try await networkManager.request(request: urlRequest, of: WeatherInfo.self)
            response.date = Date().toString()
            return response
        } catch {
            print(error.localizedDescription)
            return WeatherInfo(
                id: 000,
                name: "qqqqq",
                weather: [.mockedWeather1],
                main: .mockedTempreture1,
                wind: .mockedWind1,
                date: ""
            )
        }
    }

    public func cacheWeather(
        weatherInfo: WeatherInfo,
        cityName: String
    ) {
        do {
            try CoreDataManager.shared.insertWeatherInfo(
                weatherInfo,
                for: cityName
            )
            print("City inserted successfully")
        } catch {
            print("Failed to insert city: \(error)")
        }
    }
}

