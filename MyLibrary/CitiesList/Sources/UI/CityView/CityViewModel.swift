//
//  CityViewModel.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Combine
import Foundation
import SharedModules

final public class CityViewModel: ObservableObject {
    private let citiesListActionSubject: PassthroughSubject<CitiesListView.Action, Never>
    private let city: City

    var cityName: String {
        city.name
    }

    public init(
        city: City,
        citiesListActionSubject: PassthroughSubject<CitiesListView.Action, Never>
    ) {
        self.city = city
        self.citiesListActionSubject = citiesListActionSubject
    }
}

// MARK: - Extension
extension CityViewModel {
    func didTapDetailDisclosureButton() {
        citiesListActionSubject.send(.showHistory(city: city))
    }

    func didTapCity() {
        citiesListActionSubject.send(.showWeather(city: city))
    }
}

// MARK: Mocks

#if DEBUG
extension CityViewModel {
    static var mockCityViewModel: CityViewModel {
        CityViewModel(
            city: .mockedCity1,
            citiesListActionSubject: PassthroughSubject<CitiesListView.Action,
            Never>()
        )
    }

    static var mockCityViewModels: [CityViewModel] {
        [
            CityViewModel(
                city: .mockedCity1,
                citiesListActionSubject: PassthroughSubject<CitiesListView.Action, Never>()
            ),
            CityViewModel(
                city: .mockedCity2,
                citiesListActionSubject: PassthroughSubject<CitiesListView.Action, Never>()
            ),
            CityViewModel(
                city: .mockedCity3,
                citiesListActionSubject: PassthroughSubject<CitiesListView.Action, Never>()
            )
        ]
    }
}
#endif

