//
//  WeatherDetailsView.swift
//  
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import SwiftUI
import CoreStyles

public struct WeatherDetailsView: View {
    @ObservedObject var viewModel: WeatherDetailsViewModel
    @Binding var path: NavigationPath

    public init(
        viewModel: WeatherDetailsViewModel,
        path: Binding<NavigationPath>
    ) {
        self.viewModel = viewModel
        self._path = path
    }

    public var body: some View {
        NavigationStack(path: $path) {
            VStack {
                weatherInfoDetails
            }
            .navigationTitle(viewModel.cityName)
            .task {
                await viewModel.fetchWeather()
            }
            Spacer()
        }
    }

    private var weatherInfoDetails: some View {
        VStack(
            alignment: .leading,
            spacing: Style.Spacing.lg
        ) {
            header
//            icon
            description
            temp
            humidity
            windSpeed
        }
    }

    private var header: some View {
        Text("Weather information for \(viewModel.cityName) received on \(viewModel.date)")
    }

    @ViewBuilder
    private var icon: some View {
        VStack {
            if let url = URL(string: viewModel.iconUrl()) {
                Rectangle()
                    .asyncImage(url: url)
            }
        }
        .clipShape(.rect(cornerRadius: Style.Spacing.md))
    }

    private var description: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("Description: ")
                .typography(.heading03)

            Text(viewModel.description)
                .typography(.caption01)
        }
    }

    private var temp: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("Temp: ")
                .typography(.heading03)

            Text(viewModel.temp)
                .typography(.caption01)
        }
    }

    private var humidity: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("Humidity: ")
                .typography(.heading03)

            Text(viewModel.humidity)
                .typography(.caption01)
        }
    }

    private var windSpeed: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("Wind Speed: ")
                .typography(.heading03)

            Text(viewModel.windSpeed)
                .typography(.caption01)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            weatherDetailsView()
        }
    }

    private static func weatherDetailsView() -> some View {
        @State var path = NavigationPath()

        return WeatherDetailsView(
            viewModel: .mockWeatherDetailsViewModel,
            path: $path
        )
    }
}
#endif
