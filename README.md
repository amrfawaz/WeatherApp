# WeatherApp

# README #
Table of contents:
- [Getting Started](#getting-started)
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Folders structure](#folders-structure)


## Getting Started
To get Around Egypt application up and running follow this simple step.
Install applications required in development process.

## Requirements ##

- Xcode 15.4
- iOS SDK 16+
- Swift 5.9+

## Features

**Home Screen (Cities List)**
- Displays a scrollable list of saved cities
- Each city item shows:
- City name (tappable)
- Info button (detailDisclosureButton)
- Persistent "Add City" button
- Data persisted using CoreData
- Works in offline mode

**Add City Screen**
- Text input field for city name
- Add button (CTA)
Functionality:
- Accepts city name input (e.g., "London")
- Saves new city to CoreData
- Returns to cities list automatically


**Weather Details Screen**
- Accessed by tapping city name
- Shows current weather information:
  - Temperature
  - Weather conditions
  - Humidity
  - Wind speed
- Data persistence:
  - Caches weather data in CoreData
  - Available offline

  
**Weather History Screen**
- Accessed via detailDisclosureButton
- Displays historical weather data
- Features:
  - List of past weather records
  - Timestamp for each record
  - Weather details per record
  - Uses cached data from CoreData

## Architecture ##

The app is built using Clean architecture with MVVM (Model-View-ViewModel) architecture pattern for presentation layer, following Domain-Driven Design principles. The codebase is organized into domain, data, and presentation layers.
- SwiftUI is used for creating views
- It uses Combine for view model bindings and logic.
- URLSession is used for API connections.
- CoreData is used for data presisting.
- SPM is used as a dependencies manager
- App is modularized - has one package with most of the sources and is divided into libraries inside this package, see [Modularization part 1](https://www.pointfree.co/episodes/ep171-modularization-part-1) for more info
- For generating resource enums (images, string), we use a [SwiftGen] https://github.com/SwiftGen/SwiftGen 


- **Domain Layer**:
  - Contains domain models representing Experiences entities.
  - Includes use cases for fetching Cities data.

- **Data Layer**:
  - Manages network requests and data retrieval from the openweathermap.org API.
  - Recent data is cached in CoreData DB.

- **Presentation Layer**:
  - Uses SwiftUI for creating views.
  - Uses Combine for view model bindings and logic.



### Folders structure ##

- {FeatureName}
    - Sources
      - DI
          - Container.swift - file with dependency injection registration
      - Data
        - DataSources
        - RepositoriesImp 
      - Domain
        - Repositories
        - UseCases
      - Resources
          - Images
              - assets catalog
              - Generated - folder with a enum generated by SwiftGen
      - UI
          - {ScreenName1}
              - {ScreenName1}View.swift
              - {ScreenName1}ViewModel.swift
              - {ScreenName1}ViewIntent.swift
              - ...
          - {ScreenName2}
              - {ScreenName2}View.swift
              - {ScreenName2}ViewModel.swift
              - {ScreenName2}ViewIntent.swift
              - ...
