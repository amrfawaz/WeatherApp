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
import WeatherHistory

public struct CitiesListView: View {
    enum Constants {
        static let citiesTitle = "Cities"
        static let addIcon = "plus"
        static let clearImageName = "xmark.circle.fill"
        static let cancelText = "Cancel"
        static let searchText = "Search"
    }

    public enum Action: Equatable {
        case showSearchView
        case showWeather(city: City)
        case showHistory(city: City)
    }

    enum NavigationDestination: Hashable {
        case search
        case weatherDetails(city: City)
//        case history(city: City)
    }

    @StateObject private var viewModel: CitiesListViewModel
    @State private var selectedCity: String = ""
    @State private var navigationPath = NavigationPath()
    @State private var showingHistorySheet = false  // Add this state

    public init (viewModel: CitiesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            NavigationStack(path: $navigationPath) {
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
                    guard !selectedCity.isEmpty else { return }
                    viewModel.addCity(cityName: selectedCity)
                    selectedCity = ""
                    viewModel.resetSelectedCity()
                }
                .onReceive(viewModel.actionSubject) { action in
                    handleActions(action)
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
//                    destinationView(for: destination)

                    switch destination {
                    case .search:
                        let searchViewModel = Container.getSearchViewModel()
                        SearchView(
                            viewModel: searchViewModel,
                            path: _navigationPath,
                            searchText: $selectedCity
                        )
                    case .weatherDetails(let city):
                        let weatherDetailsViewModel = Container.getWeatherDetailsViewModel(city: city)
                        WeatherDetailsView(
                            viewModel: weatherDetailsViewModel,
                            path: $navigationPath
                        )
//                    case .history(let city):
//                        let weatherHistoryViewModel = Container.getWeatherHistoryViewModel(city: city)
//                        WeatherHistoryView(
//                            viewModel: weatherHistoryViewModel,
//                            path: $navigationPath
//                        )
                    }
                }
                .sheet(isPresented: $showingHistorySheet, content: {
                    if let city = viewModel.selectedHistoryCity {
                        let weatherHistoryViewModel = Container.getWeatherHistoryViewModel(city: city)
                        WeatherHistoryView(
                            viewModel: weatherHistoryViewModel,
                            path: $navigationPath
                        )
                    }
                })

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

    private func handleActions(_ action: Action) {
        switch action {
        case .showSearchView:
            navigationPath.append(NavigationDestination.search)
        case .showWeather(let city):
            navigationPath.append(NavigationDestination.weatherDetails(city: city))
        case .showHistory(let city):
            viewModel.selectedHistoryCity = city
            showingHistorySheet = true
//            navigationPath.append(NavigationDestination.history(city: city))
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
                let cityViewModel = CityViewModel(
                    city: city,
                    citiesListActionSubject: viewModel.actionSubject
                )
                CityView(viewModel: cityViewModel)
                
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            citiesListView()
        }
    }

    private static func citiesListView() -> some View {
        CitiesListView(viewModel: .mockCitiesListViewModel)
    }
}
#endif
