//
//  WeatherHistoryView.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import SwiftUI
import CoreStyles

public struct WeatherHistoryView: View {
    @ObservedObject var viewModel: WeatherHistoryViewModel
    @Binding var path: NavigationPath

    public init(
        viewModel: WeatherHistoryViewModel,
        path: Binding<NavigationPath>
    ) {
        self.viewModel = viewModel
        self._path = path
    }

    public var body: some View {
        VStack {
            NavigationStack(path: $path) {
                VStack {
                    content
                        .padding(.top, Style.Spacing.md)
                }
                .onFirstAppear {
                    viewModel.getWeatherHistory()
                }
                .navigationTitle(viewModel.title)
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

    private var list: some View {
        LazyVStack {
            ForEach(viewModel.weatherInfo, id: \.date) { weatherHistory in
                let weatherCardViewModel = WeatherCardViewModel(weatherInfo: weatherHistory)
                WeatherCardView(viewModel: weatherCardViewModel)
//                    .onTapGesture {
////                        viewModel.didTapCity(city: city)
//                    }
                
            }
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
        return WeatherHistoryView(viewModel: .mockWeatherHistoryViewModel, path: $path)
    }
}
#endif
