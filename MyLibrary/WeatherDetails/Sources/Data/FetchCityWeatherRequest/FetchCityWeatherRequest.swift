//
//  FetchCityWeatherRequest.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import Foundation
import EnvironmentVariables
import NetworkProvider

public protocol FetchCityWeatherRequest {
    var endPoint: String { get }
    var request: URLRequest? { get }
}

extension FetchCityWeatherRequest {
    var request: URLRequest? {
        guard let url = URL(string: endPoint) else { return nil }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems?.append(URLQueryItem(name: "appid", value: EnvironmentVariables.apiKey.rawValue))

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.setValue(EnvironmentVariables.accept.rawValue, forHTTPHeaderField: "accept")
        request.setValue(EnvironmentVariables.apiKey.rawValue, forHTTPHeaderField: "appid")
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
}

struct WeatherRequest: FetchCityWeatherRequest {
    let city: String

    var endPoint: String {
        EnvironmentVariables.waether(city: city)
    }
}
