//
//  CitiesListViewModelTests.swift
//  
//
//  Created by Amr Abd-Elhakim on 18/04/2025.
//

import XCTest
import Combine
import SharedModules
@testable import CitiesList
@testable import CoreDataManager

final class CitiesListViewModelTests: XCTestCase {
    private var sut: CitiesListViewModel?
    private var mockCitiesListUseCase: MockCitiesListUseCase!

    var cancellables: Set<AnyCancellable>!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        sut = CitiesListViewModel.mockCitiesListViewModel
        mockCitiesListUseCase = MockCitiesListUseCase()
        cancellables = []
        coreDataManager = CoreDataManager.shared
    }

    override func tearDown() {
        sut = nil
        mockCitiesListUseCase = nil
        cancellables = nil
        coreDataManager = nil
        super.tearDown()
    }

    func testInitialState() throws {
        XCTAssertEqual(sut!.cities.count, 3, "Number of cities is 3")
        XCTAssertFalse(sut!.cities.isEmpty, "Cities shouldn't be empty")
        XCTAssertFalse(sut!.isLoading)
        XCTAssertTrue(sut!.searchCityName.isEmpty, "Search city is empty array is empty")
        XCTAssertNil(sut!.selectedCity, "Selected City is nil")
        XCTAssertEqual(sut!.cities, City.mockedCities, "Cities is equal to mocked cities")
    }

    func testAddCityAction() {
        // Given
        var receivedAction: CitiesListView.Action?
        sut?.actionSubject
            .sink { action in
                receivedAction = action
            }
            .store(in: &cancellables)

        // When
        sut?.addCityAction()

        // Then
        XCTAssertEqual(receivedAction, .showSearchView, "Add city is trigged successfully")
    }

    func testAddCity() throws {
        // Given
        let cityName = "New York"
        let citiesCountBefore = sut?.cities.count

        // When
        sut?.addCity(cityName: cityName)
        try coreDataManager.insertCity(City(id: 0, name: cityName, weatherHistory: []))
        let savedCity = try coreDataManager.retrieveCity(byName: cityName)

        // Then
        XCTAssertEqual(sut?.cities.count, citiesCountBefore! + 1)
        XCTAssertEqual(sut?.cities.last?.name, cityName)
        XCTAssertNotNil(savedCity)
        XCTAssertEqual(savedCity?.name, cityName)
    }

    func testCantAddDuplicatedCitites() throws {
        // Given
        let cityName = "New York"
        sut?.fetchCachedCities()
        let citiesCountBefore = sut?.cities.count

        // When
        sut?.addCity(cityName: cityName)
        try coreDataManager.insertCity(City(id: 0, name: cityName, weatherHistory: []))

        // Then
        XCTAssertNotEqual(sut?.cities.count, citiesCountBefore! + 1, "The City is already added, so the count won't be increased")
    }

    func testResetSelectedCity() {
        // Given
        sut?.searchCityName = "Test"

        // When
        sut?.resetSelectedCity()

        // Then
        XCTAssertEqual(sut?.searchCityName, "", "Search city name should be empty")
    }

    func testFetchCachedCities() {
        // Given
        let mockCities = [
            City(id: 1, name: "Paris", weatherHistory: []),
            City(id: 2, name: "London", weatherHistory: [])
        ]
        mockCitiesListUseCase.mockCities = mockCities

        // When
        sut?.fetchCachedCities()

        // Then
        XCTAssertEqual(sut?.cities.count, mockCities.count)
    }
}
