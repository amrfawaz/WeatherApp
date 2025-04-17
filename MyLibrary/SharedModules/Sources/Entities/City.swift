//
//  City.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation

public struct City: Identifiable, Hashable {
    public let id: Int
    public let name: String
    public var weatherHistory: [WeatherInfo]

    public init(
        id: Int,
        name: String,
        weatherHistory: [WeatherInfo]
    ) {
        self.id = id
        self.name = name
        self.weatherHistory = weatherHistory
    }
}

// MARK: - Mocks

#if DEBUG
extension City {
    public static var mockedCity1: City {
        City(
            id: 2988507,
            name: "Paris", weatherHistory: WeatherInfo.mockedWeatherInfo
        )
    }
    public static var mockedCity2: City {
        City(
            id: 360630,
            name: "Cairo", weatherHistory: WeatherInfo.mockedWeatherInfo
        )
    }
    public static var mockedCity3: City {
        City(
            id: 2643743,
            name: "London", weatherHistory: WeatherInfo.mockedWeatherInfo
        )
    }

    public static var mockedCities: [City] {
        [
            City(
                id: 2988507,
                name: "Paris", weatherHistory: WeatherInfo.mockedWeatherInfo
            ),
            City(
                id: 360630,
                name: "Cairo", weatherHistory: WeatherInfo.mockedWeatherInfo
            ),
            City(
                id: 2643743,
                name: "London", weatherHistory: WeatherInfo.mockedWeatherInfo
            ),
            
        ]
    }
}
#endif
