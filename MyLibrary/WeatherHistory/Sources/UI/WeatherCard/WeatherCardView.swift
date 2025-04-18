//
//  WeatherCardView.swift
//
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import SwiftUI
import CoreStyles

public struct WeatherCardView: View {
    @ObservedObject var viewModel: WeatherCardViewModel

    public init(viewModel: WeatherCardViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(
            alignment: .leading,
            spacing: Style.Spacing.xxs
        ) {
            Text(viewModel.date)
                .typography(.button01)
                .foregroundColor(Color(uiColor: .darkGray))

            Text(viewModel.cityNameAndTemp)
                .typography(.heading03)
                .foregroundColor(.teal)

            Divider()
        }
        .padding(.horizontal, Style.Spacing.md)
    }
}

// MARK: - Preview

#if DEBUG
struct WeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            weatherCardView()
        }
    }

    private static func weatherCardView() -> some View {
        WeatherCardView(viewModel: .mockWeatherCardViewModel)
    }
}
#endif
