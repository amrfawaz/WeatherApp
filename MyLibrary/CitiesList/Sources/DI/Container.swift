//
//  Container.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation
import Search
import WeatherDetails
import SharedModules
import WeatherHistory

final class Container {
    static func getSearchViewModel() -> SearchViewModel {
        SearchViewModel()
    }

    static func getWeatherDetailsViewModel(city: City) -> WeatherDetailsViewModel {
        var fetchCityWeatherUseCase: FetchCityWeatherUseCase {
            let weatherDetailsRepository = WeatherDetailsRepositoryImp(
                api: WeatherAPI(),
                coreDataApi: CoreDataStoreAPI()
            )
            return FetchCityWeatherUseCase(repository: weatherDetailsRepository)
        }

        return WeatherDetailsViewModel(city: city, fetchCityWeatherUseCase: fetchCityWeatherUseCase)
    }

    static func getWeatherHistoryViewModel(city: City) -> WeatherHistoryViewModel {
        WeatherHistoryViewModel(
            cityName: city.name,
            weatherHistoryUseCase: WeatherHistoryUseCase(repository: WeatherHistoryRepositiryImp(coreDataApi: CoreDataStoreAPI()))
        )
    }
}
