//
//  CitiesListUseCase.swift
//
//
//  Created by Amr Abd-Elhakim on 19/04/2025.
//

import Foundation
import SharedModules

public class CitiesListUseCase {
    private let repository: CitiesListRepository

    public init(repository: CitiesListRepository) {
        self.repository = repository
    }

    func cacheCity(city: City) {
        repository.cacheCity(city)
    }

    func getAllCities() -> [City] {
        repository.fetchCachedCities()
    }
}
