//
//  WeatherCardViewModel.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Combine
import Foundation
import SharedModules

final public class WeatherCardViewModel: ObservableObject {
    let weatherInfo: WeatherInfo

    public init(weatherInfo: WeatherInfo) {
        self.weatherInfo = weatherInfo
    }

    private var temp: String {
        "\(weatherInfo.main.temp) K"
    }

    var date: String {
        weatherInfo.date ?? ""
    }

    var cityNameAndTemp: String {
        weatherInfo.name + ", " + temp
    }
}

// MARK: Mocks

#if DEBUG
extension WeatherCardViewModel {
    static var mockWeatherCardViewModel: WeatherCardViewModel {
        WeatherCardViewModel(weatherInfo: .mockedWeatherInfo.first!)
    }
}
#endif

