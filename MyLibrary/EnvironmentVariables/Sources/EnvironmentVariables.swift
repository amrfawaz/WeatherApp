//
//  EnvironmentVariables.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation

public enum EnvironmentVariables: String {
    case baseUrl = "https://api.openweathermap.org/data"
    case version = "/2.5"
    case apiKey = "f5cb0b965ea1564c50c6f1b74534d823"
    case accept = "application/json"
    case weatherApi = "/weather?q="

    public static func waether(city: String) -> String {
        EnvironmentVariables.baseUrl.rawValue +
        EnvironmentVariables.version.rawValue +
        EnvironmentVariables.weatherApi.rawValue +
        "\(city)"
    }
}
