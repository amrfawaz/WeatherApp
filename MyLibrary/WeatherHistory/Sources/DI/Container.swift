//
//  Container.swift
//  
//
//  Created by Amr Abd-Elhakim on 19/04/2025.
//

import Search
import WeatherDetails
import SharedModules


final class Container {
    static func getWeatherDetailsViewModel(
        city: City,
        weatherInfo: WeatherInfo
    ) -> WeatherDetailsViewModel {
        var fetchCityWeatherUseCase: FetchCityWeatherUseCase {
            let weatherDetailsRepository = WeatherDetailsRepositoryImp(
                api: WeatherAPI(),
                coreDataApi: WeatherDetails.CoreDataStoreAPI()
            )
            return FetchCityWeatherUseCase(repository: weatherDetailsRepository)
        }

        return WeatherDetailsViewModel(
            city: city,
            fetchCityWeatherUseCase: fetchCityWeatherUseCase,
            weatherInfo: weatherInfo
        )
    }
}
