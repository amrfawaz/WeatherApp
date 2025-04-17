//
//  SearchView.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import SwiftUI
import CoreStyles

public struct SearchView: View {
    enum Constants {
        static let magnifyingGlass = "magnifyingglass"
        static let searchPlaceholderText = "Search..."
        static let clearImageName = "xmark.circle.fill"
        static let cancelText = "Cancel"
        static let addCityText = "Add City"
    }
    enum Action: Equatable {
        case search
    }

    @State var path: NavigationPath
    @Binding private var searchText: String
    @ObservedObject private var viewModel: SearchViewModel
    @FocusState private var isFocused: Bool

    public init(
        viewModel: SearchViewModel,
        path: State<NavigationPath>,
        searchText: Binding<String>
    ) {
        self.viewModel = viewModel
        self._path = path
        self._searchText = searchText
    }

    public var body: some View {
        VStack {
            searchBarView

            searchButton
                .onReceive(viewModel.actionSubject) { action in
                    path.removeLast()
                }
            
            Spacer()
        }
    }
}

// MARK: - Extension

extension SearchView {
    private var searchBarView: some View {
        HStack {
            HStack {
                magnifyingGlassImage

                searchTextField

                clearButton
            }
            .padding(Style.Spacing.sm)
            .background(
                RoundedRectangle(cornerRadius: Style.CornerRadius.lg)
                    .fill(Color(.systemGray6))
            )

            cancelButton
        }
        .padding()
        .animation(.default, value: isFocused)
    }

    private var magnifyingGlassImage: some View {
        Image(systemName: Constants.magnifyingGlass)
            .foregroundColor(.gray)
    }

    private var searchTextField: some View {
        TextField(Constants.searchPlaceholderText, text: $searchText)
            .focused($isFocused)
            .submitLabel(.search)
            .onSubmit {
                viewModel.addCity(city: viewModel.searchText)
                path.removeLast()
            }
    }

    @ViewBuilder
    private var clearButton: some View {
        if !searchText.isEmpty {
            Button(action: {
                searchText = ""
                viewModel.clearSearch()
            }) {
                Image(systemName: Constants.clearImageName)
                    .foregroundColor(.gray)
            }
        }
    }

    @ViewBuilder
    private var cancelButton: some View {
        if isFocused {
            Button(Constants.cancelText) {
                viewModel.clearSearch()
                isFocused = false
            }
            .transition(.move(edge: .trailing))
        }
    }

    private var searchButton: some View {
        VStack {
            Button(action: {
                // Update the shared Binding and perform search
                viewModel.addCity(city: searchText)
                isFocused = false
            }) {
                Text(Constants.addCityText)
                    .foregroundColor(.white)
                    .typography(.heading03)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: Style.Size.searchButtonHeight)
                    .background(Color.blue)
                    .cornerRadius(Style.CornerRadius.lg)
            }
            .padding(.horizontal, Style.Spacing.md)

            Spacer()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        @State var mockSearchText: String = "Sample City"

        VStack {
            searchView(
                .mocksearchViewModel,
                searchText: $mockSearchText
            )
        }
    }

    private static func searchView(_ viewModel: SearchViewModel, searchText: Binding<String>) -> some View {
        @State var path = NavigationPath()

        return SearchView(
            viewModel: viewModel,
            path: _path,
            searchText: searchText
        )
    }
}
#endif
