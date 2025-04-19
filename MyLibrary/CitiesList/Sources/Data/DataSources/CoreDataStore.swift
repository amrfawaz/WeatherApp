//
//  CoreDataStore.swift
//
//
//  Created by Amr Abd-Elhakim on 19/04/2025.
//

import Foundation
import SharedModules
import CoreDataManager

public protocol CoreDataStoreProtocol {
    func saveCity(_ city: City)
    func fetchCachedCities() -> [City]
}

public class CoreDataStoreAPI: CoreDataStoreProtocol {
    public init() {}

    public func saveCity(_ city: City) {
        do {
            try CoreDataManager.shared.insertCity(city)
            print("City inserted successfully")
        } catch {
            print("Failed to insert city: \(error)")
        }
    }

    public func fetchCachedCities() -> [City] {
        do {
            print("Retrieved All cached cities successfully")
            return try CoreDataManager.shared.retrieveAllCities()
        } catch {
            print("Failed to insert city: \(error)")
            return  []
        }
    }
}
