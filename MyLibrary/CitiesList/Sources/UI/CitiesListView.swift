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
        case weatherHistory(city: City)
    }

    @StateObject private var viewModel: CitiesListViewModel
    @State private var selectedCity: String = ""
    @State private var navigationPath = NavigationPath()
    @State private var showingHistorySheet = false

    public init (viewModel: CitiesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        content
    }

    private var addCityButton: some View {
        ZStack {
            Button(action: {
                viewModel.addCityAction()
            }) {
                ZStack {
                    ModuleImage.buttonRight.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Style.Size.addCityButtonWidth, height: Style.Size.addCityButtonHeight)
                        .padding(.top, Style.Spacing.xl)
                    
                    Text("+")
                        .typography(.heading01)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 40, height: 100)
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
        }
    }
}

// MARK: - Extenstion Cities List

private extension CitiesListView {
    var content: some View {
        VStack {
            NavigationStack(path: $navigationPath) {
                citiesScrollView
                    .background(.clear)
                    .navigationTitle(Constants.citiesTitle)
                    .navigationBarTitleDisplayMode(.inline)
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
                        destinationView(for: destination)
                    }
                    .sheet(isPresented: $showingHistorySheet, content: {
                        if let city = viewModel.selectedHistoryCity {
                            destinationView(for: .weatherHistory(city: city))
                        }
                    })
            }
        }
    }
    
    var citiesScrollView: some View {
        ScrollView {
            list
        }
        .padding(.top, Style.Spacing.md)
    }
    
    var list: some View {
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

    @ViewBuilder
    func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
        case .search:
            SearchView(
                viewModel: Container.getSearchViewModel(),
                path: _navigationPath,
                searchText: $selectedCity
            )
        case .weatherDetails(let city):
            WeatherDetailsView(
                viewModel: Container.getWeatherDetailsViewModel(city: city),
                navigationPath: _navigationPath
            )
        case .weatherHistory(let city):
            WeatherHistoryView(viewModel: Container.getWeatherHistoryViewModel(city: city))
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            citiesListView()
        }
    }

    private static func citiesListView() -> some View {
        let viewModel = CitiesListViewModel(citiesListUseCase: CitiesListUseCase(repository: CitiesListRepositoryImp(coreDataApi: CoreDataStoreAPI())))
        viewModel.cities = City.mockedCities
        return CitiesListView(viewModel: viewModel)
    }
}
#endif
