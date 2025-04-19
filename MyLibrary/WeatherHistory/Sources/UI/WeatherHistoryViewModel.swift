//
//  WeatherHistoryViewModel.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import SharedModules
import Combine

final public class WeatherHistoryViewModel: ObservableObject {
    @Published var weatherInfo: [WeatherInfo] = []

    private let weatherHistoryUseCase: WeatherHistoryUseCase
    private let cityName: String

    let actionSubject = PassthroughSubject<WeatherHistoryView.Action, Never>()

    public init(
        cityName: String,
        weatherHistoryUseCase: WeatherHistoryUseCase
    ) {
        self.cityName = cityName
        self.weatherHistoryUseCase = weatherHistoryUseCase
    }

    var title: String {
        cityName + " Historical"
    }

    @MainActor
    func getWeatherHistory() {
        weatherInfo = weatherHistoryUseCase.getWeatherHistory(cityName: cityName)
    }

    func didTapWeather(weatherInfo: WeatherInfo) {
        guard let city = weatherHistoryUseCase.getCity(cityName: cityName) else { return }
        actionSubject.send(
            .showWeather(
                city: city,
                weatherInfo: weatherInfo
            )
        )
    }
}

// MARK: Mocks

#if DEBUG

public extension WeatherHistoryViewModel {
    static var mockWeatherHistoryViewModel: WeatherHistoryViewModel {
        let viewModel = WeatherHistoryViewModel(
            cityName: "Cairo",
            weatherHistoryUseCase: WeatherHistoryUseCase(repository: WeatherHistoryRepositiryImp(coreDataApi: CoreDataStoreAPI()))
        )
        return viewModel
    }
}

#endif

