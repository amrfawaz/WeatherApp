//
//  WeatherDetailsViewModel.swift
//  
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import Combine
import SharedModules
import EnvironmentVariables

final public class WeatherDetailsViewModel: ObservableObject {
    @Published private(set) var weatherInfo: WeatherInfo?
    @Published var errorMessage: String = ""
    @Published private(set) var isLoading: Bool = false

    private let fetchCityWeatherUseCase: FetchCityWeatherUseCase
    private var city: City

    public init(
        city: City,
        fetchCityWeatherUseCase: FetchCityWeatherUseCase,
        weatherInfo: WeatherInfo? = nil
    ) {
        self.city = city
        self.fetchCityWeatherUseCase = fetchCityWeatherUseCase
        self.weatherInfo = weatherInfo
    }

    var cityName: String {
        weatherInfo?.name ?? ""
    }

    var date: String {
        weatherInfo?.date ?? ""
    }

    var description: String {
        weatherInfo?.weather.first?.description ?? ""
    }

    var temp: String {
        "\(weatherInfo?.main.temp ?? 0) K"
    }

    var humidity: String {
        "\(weatherInfo?.main.humidity ?? 0) %"
    }

    var windSpeed: String {
        "\(weatherInfo?.wind.speed ?? 0) km/h"
    }

    func iconUrl() -> String {
        guard let icon = weatherInfo?.weather.first?.icon else { return "" }
        return EnvironmentVariables.iconUrl(iconName: icon)
    }

    private func createWeatherRequest(city: String) -> FetchCityWeatherRequest {
        WeatherRequest(city: city)
    }

    func fetchWeather() async {
        guard !isLoading else { return }
        

        do {
            let response = try await fetchCityWeatherUseCase.execute(request: createWeatherRequest(city: city.name))
            DispatchQueue.main.async {
                self.isLoading = true
                self.city.weatherHistory.append(response)
                self.weatherInfo = response
                self.isLoading = false
                self.cacheWeatherDetails()
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}

private extension WeatherDetailsViewModel {
    func cacheWeatherDetails() {
        if let weatherInfo {
            fetchCityWeatherUseCase.cacheWeatherInfo(weatherInfo: weatherInfo, cityName: city.name)
        }
    }
}

// MARK: Mocks

#if DEBUG

public extension WeatherDetailsViewModel {
    static var mockWeatherDetailsViewModel: WeatherDetailsViewModel {
        WeatherDetailsViewModel(
            city: .mockedCity1,
            fetchCityWeatherUseCase: FetchCityWeatherUseCase(repository: MockWeatherDetailsRepository())
        )
    }
}

#endif
