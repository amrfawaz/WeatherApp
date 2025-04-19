//
//  CitiesListViewModel.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation
import Combine
import SharedModules

public final class CitiesListViewModel: ObservableObject {
    @Published var cities: [City] = []

    private(set) var isLoading: Bool = false

    internal var searchCityName = ""
    internal var selectedCity: City?
    var selectedHistoryCity: City?

    private let citiesListUseCase: CitiesListUseCase

    let actionSubject = PassthroughSubject<CitiesListView.Action, Never>()

    public init(citiesListUseCase: CitiesListUseCase) {
        self.citiesListUseCase = citiesListUseCase
    }

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
        cities = citiesListUseCase.getAllCities()
    }
}

private extension CitiesListViewModel {
    func saveCity(_ city: City) {
        citiesListUseCase.cacheCity(city: city)
    }
}

// MARK: Mocks

#if DEBUG

public extension CitiesListViewModel {
    static var mockCitiesListViewModel: CitiesListViewModel {
        
        let viewModel = CitiesListViewModel(citiesListUseCase: CitiesListUseCase(repository: CitiesListRepositoryImp(coreDataApi: CoreDataStoreAPI())))
                                            
        viewModel.cities = City.mockedCities
        return viewModel
    }
}

#endif

