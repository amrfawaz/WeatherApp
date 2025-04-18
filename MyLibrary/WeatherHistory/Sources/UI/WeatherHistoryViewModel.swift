//
//  WeatherHistoryViewModel.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import SharedModules

final public class WeatherHistoryViewModel: ObservableObject {
    @Published var weatherInfo: [WeatherInfo] = []

    private let weatherHistoryUseCase: WeatherHistoryUseCase
    private let cityName: String

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

