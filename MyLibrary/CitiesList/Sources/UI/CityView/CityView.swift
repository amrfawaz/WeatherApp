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
        static let iconSize = 30.0
        static let infoIcon = "info.circle"
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
        VStack {
            HStack {
                Text(viewModel.city.name)
                    .typography(.heading03)
                    .onTapGesture {
                        viewModel.didTapCity()
                    }

                Spacer()

                Image(systemName: Constants.infoIcon)
                    .resizable()
                    .typography(.body01)
                    .frame(
                        width: Constants.iconSize,
                        height: Constants.iconSize
                    )
                    .foregroundColor(.gray)
                    .onTapGesture {
                        viewModel.didTapDetailDisclosureButton()
                    }
            }

            Divider()
        }
        .padding(.horizontal, Style.Spacing.md)
        .onReceive(viewModel.actionSubject) { action in
//            handleActions(action: action)
        }
    }

    private func handleActions(action: Action) {
        switch action {
        case .showCityHistory:
            viewModel.showHistory()
        case .showCityWeather:
            viewModel.showWeather()
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
