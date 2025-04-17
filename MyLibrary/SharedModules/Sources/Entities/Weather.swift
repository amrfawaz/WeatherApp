//
//  Weather.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation

public struct WeatherInfo: Codable, Hashable {
    public let id: Int
    public let name: String
    public let weather: [Weather]
    public let main: Tempreture
    public let wind: Wind
    public var date: String?

    public init(
        id: Int,
        name: String,
        weather: [Weather],
        main: Tempreture,
        wind: Wind,
        date: String? = Date().toString()
    ) {
        self.id = id
        self.name = name
        self.weather = weather
        self.main = main
        self.wind = wind
        self.date = Date().toString()
    }
}


public struct Weather: Codable, Hashable {
    public let id: Int
    public let description: String
    public let icon: String
}

public struct Tempreture: Codable, Hashable {
    public let temp: Double
    public let humidity: Double
}

public struct Wind: Codable, Hashable {
    public let speed: Double
}


// MARK: - Mocks

#if DEBUG
extension WeatherInfo {
    public static var mockedWeatherInfo: [WeatherInfo] {
        [
            WeatherInfo(
                id: 111,
                name: "London",
                weather: [.mockedWeather1],
                main: .mockedTempreture1,
                wind: .mockedWind1,
                date: Date().toString()
            ),
            WeatherInfo(
                id: 222,
                name: "Paris",
                weather: [.mockedWeather2],
                main: .mockedTempreture2,
                wind: .mockedWind2,
                date: Date().toString()
            ),
            WeatherInfo(
                id: 333,
                name: "Cairo",
                weather: [.mockedWeather2],
                main: .mockedTempreture2,
                wind: .mockedWind2,
                date: Date().toString()
            )
        ]
    }
}

// MARK: - Weather Mocks

public extension Weather {
    static var mockedWeather1: Weather {
        Weather(
            id: 804,
            description: "overcast clouds",
            icon: "04d"
        )
    }
    static var mockedWeather2: Weather {
        Weather(
            id: 802,
            description: "scattered clouds",
            icon: "03d"
        )
    }
    static var mockedWeather3: Weather {
        Weather(
            id: 801,
            description: "few clouds",
            icon: "02d"
        )
    }
}

// MARK: - Tempreture Mocks

extension Tempreture {
    public static var mockedTempreture1: Tempreture {
        Tempreture(
            temp: 286.33,
            humidity: 91
        )
    }
    public static var mockedTempreture2: Tempreture {
        Tempreture(
            temp: 292.57,
            humidity: 81
        )
    }
    public static var mockedTempreture3: Tempreture {
        Tempreture(
            temp: 284.83,
            humidity: 42
        )
    }
}

// MARK: - Wind Mocks

extension Wind {
    public static var mockedWind1: Wind {
        Wind(speed: 5.14)
    }
    public static var mockedWind2: Wind {
        Wind(speed: 4.63)
    }
    public static var mockedWind3: Wind {
        Wind(speed: 1.54)
    }
}
#endif


public extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        return dateFormatter.string(from: Date())
    }
}
