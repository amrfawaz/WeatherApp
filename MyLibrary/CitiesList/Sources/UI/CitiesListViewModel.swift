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

final public class CitiesListViewModel: ObservableObject {
    @Published var cities: [City] = []

    var isLoading: Bool = false
    var searchCityName = ""
    var selectedCity: City?

    let actionSubject = PassthroughSubject<CitiesListView.Action, Never>()

    public init() {}

    func addCityAction() {
        actionSubject.send(.showSearchView)
    }

    
    func addCity(cityName: String) {
        let city = City(
            id: Int.random(in: 1...99999),
            name: cityName,
            weatherHistory: []
        )

        cities.append(city)
        saveCity(city)
        
    }

    func didTapCity(city: City) {
        selectedCity = city
        actionSubject.send(.showWeather)
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

extension CitiesListViewModel {
//    static var mockCitiesListViewModel: CitiesListViewModel {
//        let viewModel = CitiesListViewModel(fetchCityWeatherUseCase: FetchCityWeatherUseCase(repository: CitiesRepository()))
//        viewModel.cities = City.mockedCities
//        return viewModel
//    }
}

#endif

