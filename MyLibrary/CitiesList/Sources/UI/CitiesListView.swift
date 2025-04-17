//
//  CitiesListView.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import SwiftUI
import CoreStyles
import Search
import WeatherDetails
import SharedModules

public struct CitiesListView: View {
    enum Constants {
        static let citiesTitle = "Cities"
        static let addIcon = "plus"
        static let clearImageName = "xmark.circle.fill"
        static let cancelText = "Cancel"
        static let searchText = "Search"
    }

    enum Action: Equatable {
        case showSearchView
        case showWeather
    }

    enum NavigationDestination: Hashable {
        case search
        case weatherDetails(city: City)
        case history
    }

    @ObservedObject private var viewModel: CitiesListViewModel
    @State private var selectedCity: String = "" 
    @State private var path = NavigationPath()

    public init (viewModel: CitiesListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            NavigationStack(path: $path) {
                VStack {
                    content
                        .padding(.top, Style.Spacing.md)
                }
                .navigationTitle(Constants.citiesTitle)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addCityButton
                    }
                }
                .onFirstAppear {
                    viewModel.fetchCachedCities()
                }
                .onAppear {
                    if !selectedCity.isEmpty {
                        viewModel.addCity(cityName: selectedCity)
                        selectedCity = ""
                        viewModel.resetSelectedCity()
                    }
                }
                .onReceive(viewModel.actionSubject) { action in
                    handleActions(action: action)
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .search:
                        let searchViewModel = Container.getSearchViewModel()
                        SearchView(
                            viewModel: searchViewModel,
                            path: _path,
                            searchText: $selectedCity
                        )
                    case .weatherDetails(let city):
                        let weatherDetailsViewModel = Container.getWeatherDetailsViewModel(city: city)
                        WeatherDetailsView(
                            viewModel: weatherDetailsViewModel,
                            path: $path
                        )

                    default:
                        let searchViewModel = Container.getSearchViewModel()
                        SearchView(
                            viewModel: searchViewModel,
                            path: _path,
                            searchText: $selectedCity
                        )
                    }
                }
            }
        }
    }

    private var addCityButton: some View {
        Button(action: {
            viewModel.addCityAction()
        }) {
            Image(systemName: Constants.addIcon)
                .typography(.heading03)
        }
    }

    private func handleActions(action: Action) {
        switch action {
        case .showSearchView:
            path.append(NavigationDestination.search)
        case .showWeather:
            guard let city = viewModel.selectedCity else { return }
            path.append(NavigationDestination.weatherDetails(city: city))
        }
    }
}

// MARK: - Extenstion Cities List

private extension CitiesListView {
    var content: some View {
        ScrollView {
            VStack(spacing: Style.Spacing.md) {
                list
            }
        }
    }

    private var list: some View {
        LazyVStack {
            ForEach(viewModel.cities) { city in
                let cityViewModel = CityViewModel(city: city)
                CityView(viewModel: cityViewModel)
                    .onTapGesture {
                        viewModel.didTapCity(city: city)
                    }
                
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            citiesListView()
//        }
//    }
//
//    private static func citiesListView() -> some View {
//        CitiesListView(viewModel: CitiesListViewModel(fetchCityWeatherUseCase: FetchCityWeatherUseCase(repository: CitiesRepositoryImp(api: .fetchWeather()))))
//    }
//}
#endif
