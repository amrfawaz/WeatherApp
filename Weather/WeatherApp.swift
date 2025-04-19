//
//  WeatherApp.swift
//  Weather
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import SwiftUI
import CitiesList

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = CitiesListViewModel(citiesListUseCase: CitiesListUseCase(repository: CitiesListRepositoryImp(coreDataApi: CoreDataStoreAPI())))
            CitiesListView(viewModel: viewModel)
        }
    }
}
