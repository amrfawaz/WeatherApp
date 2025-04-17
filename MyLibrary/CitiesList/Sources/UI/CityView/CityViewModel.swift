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
    let city: City

    let actionSubject = PassthroughSubject<CityView.Action, Never>()

    public init(city: City) {
        self.city = city
    }

    func showHistory() {
        actionSubject.send(.showCityHistory)
    }

    func showWeather() {
        actionSubject.send(.showCityWeather)
    }
}

// MARK: Mocks

#if DEBUG
extension CityViewModel {
    static var mockCityViewModel: CityViewModel {
        CityViewModel(city: .mockedCity1)
    }

    static var mockCityViewModels: [CityViewModel] {
        [
            CityViewModel(city: .mockedCity1),
            CityViewModel(city: .mockedCity2),
            CityViewModel(city: .mockedCity3)
        ]
    }
}
#endif

