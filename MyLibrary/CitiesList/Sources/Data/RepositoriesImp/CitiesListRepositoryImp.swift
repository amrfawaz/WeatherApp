//
//  CitiesListRepositoryImp.swift
//
//
//  Created by Amr Abd-Elhakim on 19/04/2025.
//

import Foundation
import SharedModules
import CoreDataManager

public class CitiesListRepositoryImp: CitiesListRepository {
    private let coreDataApi: CoreDataStoreAPI

    public init(coreDataApi: CoreDataStoreAPI) {
        self.coreDataApi = coreDataApi
    }

    public func cacheCity(_ city: City) {
        coreDataApi.saveCity(city)
    }

    public func fetchCachedCities() -> [City] {
        coreDataApi.fetchCachedCities()
    }
}

// MARK: - Mocks

#if DEBUG
public final class MockCitiesListRepositoryImp: CitiesListRepository {

    public func cacheCity(_ city: City) {}

    public func fetchCachedCities() -> [City] {
        City.mockedCities
    }
}
#endif
