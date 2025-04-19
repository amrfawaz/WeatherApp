//
//  WeatherHistoryView.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import SwiftUI
import CoreStyles
import SharedModules
import WeatherDetails

public struct WeatherHistoryView: View {
    enum Action: Equatable {
        case showWeather(
            city: City,
            weatherInfo: WeatherInfo
        )
    }
    enum NavigationDestination: Hashable {
        case weatherDetails(
            city: City,
            weatherInfo: WeatherInfo
        )
    }

    @ObservedObject var viewModel: WeatherHistoryViewModel
    @State private var navigationPath = NavigationPath()

    public init(viewModel: WeatherHistoryViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            NavigationStack(path: $navigationPath) {
                VStack {
                    content
                        .padding(.top, Style.Spacing.md)
                }
                .onFirstAppear {
                    viewModel.getWeatherHistory()
                }
                .navigationTitle(viewModel.title)
                .onReceive(viewModel.actionSubject) { action in
                    handleActions(action)
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .weatherDetails(let city, let weatherInfo):
                        let weatherDetailsViewModel = Container.getWeatherDetailsViewModel(city: city, weatherInfo: weatherInfo)
                        WeatherDetailsView(
                            viewModel: weatherDetailsViewModel,
                            navigationPath: _navigationPath
                        )
                    }
                }

            }
        }
    }
}

private extension WeatherHistoryView {
    var content: some View {
        ScrollView {
            VStack(spacing: Style.Spacing.md) {
                list
            }
        }
    }

    var list: some View {
        LazyVStack {
            ForEach(viewModel.weatherInfo, id: \.date) { weatherHistory in
                let weatherCardViewModel = WeatherCardViewModel(weatherInfo: weatherHistory)
                WeatherCardView(viewModel: weatherCardViewModel)
                    .onTapGesture {
                        viewModel.didTapWeather(weatherInfo: weatherHistory)
                    }
                
            }
        }
    }

    private func handleActions(_ action: Action) {
        switch action {
        case .showWeather(let city, let weatherInfo):
            navigationPath.append(
                NavigationDestination.weatherDetails(
                    city: city,
                    weatherInfo: weatherInfo
                )
            )
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WeatherHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            citiesListView()
        }
    }

    private static func citiesListView() -> some View {
        @State var path = NavigationPath()
        return WeatherHistoryView(viewModel: .mockWeatherHistoryViewModel)
    }
}
#endif
