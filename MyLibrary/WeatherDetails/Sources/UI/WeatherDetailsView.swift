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
    @State private var navigationPath = NavigationPath()

    public init(
        viewModel: WeatherDetailsViewModel,
        navigationPath: State<NavigationPath>
    ) {
        self.viewModel = viewModel
        self._navigationPath = navigationPath
    }

    public var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                weatherInfoDetails
            }
            .navigationTitle(viewModel.cityName)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if viewModel.weatherInfo == nil {
                    await viewModel.fetchWeather()
                }
            }
            .padding(.horizontal, Style.Spacing.md)

            Spacer()

            header
        }
    }

    private var weatherInfoDetails: some View {
        VStack(spacing: Style.Spacing.lg) {
            VStack(alignment: .center) {
//                icon
            }

            VStack(
                alignment: .leading,
                spacing: Style.Spacing.md
            ) {
                description
                temp
                humidity
                windSpeed
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Style.Spacing.lg)
        .background(Color.white)
        .cornerRadius(Style.CornerRadius.xxxl)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 8,
            x: 0,
            y: 4
        )
    }

    private var header: some View {
        Text("Weather information for \(viewModel.cityName) received on \(viewModel.date)")
            .foregroundColor(Color(uiColor: .darkGray))
            .multilineTextAlignment(.center)
    }

    @ViewBuilder
    private var icon: some View {
        if let url = URL(string: viewModel.iconUrl()) {
            VStack(alignment: .center) {
                AsyncImage(url: url)
                    .frame(width: 70, height: 70)
                    .clipShape(.rect(cornerRadius: Style.CornerRadius.md))
            }
        }
    }

    private var description: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("DESCRIPTION: ")
                .typography(.button01)
                .foregroundColor(Color(uiColor: .darkGray))
            

            Text(viewModel.description)
                .typography(.heading02)
                .foregroundColor(.teal)
        }
    }

    private var temp: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("TEPRETURE: ")
                .typography(.button01)
                .foregroundColor(Color(uiColor: .darkGray))

            Text(viewModel.temp)
                .typography(.heading02)
                .foregroundColor(.teal)
        }
    }

    private var humidity: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("HUMIDITY: ")
                .typography(.button01)
                .foregroundColor(Color(uiColor: .darkGray))

            Text(viewModel.humidity)
                .typography(.heading02)
                .foregroundColor(.teal)
        }
    }

    private var windSpeed: some View {
        HStack(spacing: Style.Spacing.xs) {
            Text("WINDSPEED: ")
                .typography(.button01)
                .foregroundColor(Color(uiColor: .darkGray))

            Text(viewModel.windSpeed)
                .typography(.heading02)
                .foregroundColor(.teal)
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
        @State var navigationPath = NavigationPath()

        return WeatherDetailsView(
            viewModel: .mockWeatherDetailsViewModel,
            navigationPath: _navigationPath
        )
    }
}
#endif
