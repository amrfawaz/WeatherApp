//
//  CityView.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import SwiftUI
import CoreStyles

public struct CityView: View {
    enum Constants {
        static let iconWidth = 22.0
        static let iconHight = 25.0
        static let infoIcon = "info.circle.fill"
    }

    enum Action {
        case showCityHistory
        case showCityWeather
    }

    @ObservedObject private var viewModel: CityViewModel

    public init(viewModel: CityViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        content
            .padding(.horizontal, Style.Spacing.md)
    }
}

// MARK: - Extenstion

private extension CityView {
    var content: some View {
        VStack {
            HStack {
                cityNameText

                Spacer()

                detailsDisclosureButton
            }
            .frame(height: Style.Size.cityViewHeight)

            Divider()
        }
    }

    var cityNameText: some View {
        Text(viewModel.cityName)
            .typography(.heading02)
            .foregroundColor(Color(uiColor: .darkGray))
            .onTapGesture {
                viewModel.didTapCity()
            }
    }

    var detailsDisclosureButton: some View {
        Image(systemName: Constants.infoIcon)
            .resizable()
            .typography(.body01)
            .frame(
                width: Constants.iconWidth,
                height: Constants.iconHight
            )
            .foregroundColor(.teal)
            .onTapGesture {
                viewModel.didTapDetailDisclosureButton()
            }
    }
}

// MARK: - Preview

#if DEBUG
struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            cityView()
        }
    }

    private static func cityView() -> some View {
        CityView(viewModel: .mockCityViewModel)
    }
}
#endif
