//
//  CitiesListRepository.swift
//
//
//  Created by Amr Abd-Elhakim on 19/04/2025.
//

import Foundation
import SharedModules

public protocol CitiesListRepository {
    func cacheCity(_ city: City)
    func fetchCachedCities() -> [City]
}
