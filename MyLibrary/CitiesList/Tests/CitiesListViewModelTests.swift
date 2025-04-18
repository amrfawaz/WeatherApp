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
    var cancellables: Set<AnyCancellable>!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        sut = CitiesListViewModel.mockCitiesListViewModel
        cancellables = []
        coreDataManager = CoreDataManager.shared
    }

    override func tearDown() {
        sut = nil
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

    func testDidTapCity() {
        // Given
        let testCity = City(id: 1, name: "Test City", weatherHistory: [])
        var receivedAction: CitiesListView.Action?
        sut?.actionSubject
            .sink { action in
                receivedAction = action
            }
            .store(in: &cancellables)

        // When
        sut?.didTapCity(city: testCity)

        // Then
        XCTAssertEqual(sut?.selectedCity?.id, testCity.id)
        XCTAssertEqual(receivedAction, .showWeather)
    }

    func testResetSelectedCity() {
        // Given
        sut?.searchCityName = "Test"

        // When
        sut?.resetSelectedCity()

        // Then
        XCTAssertTrue(sut!.searchCityName.isEmpty)
    }

    func testFetchCachedCitiesSuccess() {
        // Given
        let mockCities = sut?.cities

        // Then
        XCTAssertEqual(sut?.cities.count, 3, "Number of cities is 3")
        XCTAssertEqual(sut?.cities[0].name, "Paris", "Paris is first city in array")
        XCTAssertEqual(sut?.cities[1].name, "Cairo", "Cairo is first city in array")
        XCTAssertEqual(sut?.cities[2].name, "London", "London is first city in array")
    }
}
