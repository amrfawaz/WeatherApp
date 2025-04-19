//
//  CitiesListViewModel.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation
import Combine
import SharedModules
import CoreDataManager

public final class CitiesListViewModel: ObservableObject {
    @Published var cities: [City] = []

    private(set) var isLoading: Bool = false

    internal var searchCityName = ""
    internal var selectedCity: City?

    var selectedHistoryCity: City?

    let actionSubject = PassthroughSubject<CitiesListView.Action, Never>()

    public init() {}

    func addCityAction() {
        actionSubject.send(.showSearchView)
    }

    
    func addCity(cityName: String) {
        guard !cities.contains(where: { $0.name == cityName }) else { return }

        let city = City(
            id: Int.random(in: 1...99999),
            name: cityName,
            weatherHistory: []
        )

        cities.append(city)
        saveCity(city)
    }


    func resetSelectedCity() {
        searchCityName = ""
    }

    func fetchCachedCities() {
        do {
            cities = try CoreDataManager.shared.retrieveAllCities()
            print("Retrieved All cached cities successfully")
        } catch {
            print("Failed to insert city: \(error)")
        }
    }
}

private extension CitiesListViewModel {
    func saveCity(_ city: City) {
        do {
            try CoreDataManager.shared.insertCity(city)
            print("City inserted successfully")
        } catch {
            print("Failed to insert city: \(error)")
        }
    }
}

// MARK: Mocks

#if DEBUG

public extension CitiesListViewModel {
    static var mockCitiesListViewModel: CitiesListViewModel {
        let viewModel = CitiesListViewModel()
        viewModel.cities = City.mockedCities
        return viewModel
    }
}

#endif

