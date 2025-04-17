//
//  SearchViewModel.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Combine
import Foundation

final public class SearchViewModel: ObservableObject {
    @Published var searchText = ""

    let actionSubject = PassthroughSubject<SearchView.Action, Never>()

    private var cancellables = Set<AnyCancellable>()

    public init() {
        $searchText
            .sink { [weak self] text in
                if !text.isEmpty {
                    self?.addCity(city: text)
                }
            }
            .store(in: &cancellables)
    }

    func addCity(city: String) {
        guard !city.isEmpty else {
            return
        }
        actionSubject.send(.search)
    }
    
    func clearSearch() {
        searchText = ""
    }
}

// MARK: Mocks

#if DEBUG
extension SearchViewModel {
    static var mocksearchViewModel: SearchViewModel {
        SearchViewModel()
    }
}
#endif
