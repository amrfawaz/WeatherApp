//
//  FetchCityWeatherUseCase.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import NetworkProvider
import SharedModules

public class FetchCityWeatherUseCase {
    private let repository: WeatherDetailsRepository

    public init(repository: WeatherDetailsRepository) {
        self.repository = repository
    }

    func execute<T: FetchCityWeatherRequest>(request: T) async throws -> WeatherInfo {
        return try await repository.fetchWeatherDetails(request: request)
    }
    func cacheWeatherInfo(weatherInfo: WeatherInfo, cityName: String) {
        repository.cacheWeatherDetails(weatherInfo: weatherInfo, cityName: cityName)
    }
    func getWeatherInfo(cityName: String, date: String) -> WeatherInfo? {
        return repository.getWeatherDetails(cityName: cityName, date: date)
    }
}

// MARK: - Mocks

#if DEBUG
final class MockFetchCityWeatherUseCase: FetchCityWeatherUseCase {
    var responseData: Data?
    var responseError: NetworkError?

    override func execute<T>(request: T) async throws -> WeatherInfo where T : FetchCityWeatherRequest {
        if let error = responseError {
            throw error
        }

        guard let data = responseData else {
            throw NetworkError.noData
        }

        do {
            return try JSONDecoder().decode(WeatherInfo.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
#endif
