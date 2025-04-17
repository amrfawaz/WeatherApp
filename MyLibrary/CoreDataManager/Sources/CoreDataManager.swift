//
//  File.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import CoreData
import SharedModules

// MARK: - Core Data Manager
public class CoreDataManager {
    public static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let modelName = "WeatherApp"
        
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd") ??
              Bundle(for: type(of: self)).url(forResource: modelName, withExtension: "momd") ??
              Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Failed to find CoreData model named \(modelName)")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create model from URL: \(modelURL)")
        }
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        
        // Create the store description with a specific file URL
        let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("\(modelName).sqlite")
        
        print("💾 Database URL:", storeURL.path)
        
        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                print("Error loading store:", error)
                return
            }
            print("✅ Successfully loaded persistent store")
        }
        
        // Configure the context
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    
    public var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Save Context
    public func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Context saved successfully")
            } catch {
                print("❌ Failed to save context:", error)
                throw error
            }
        }
    }
    
    // MARK: - City Operations
    public func insertCity(_ city: City) throws {
        let context = persistentContainer.viewContext
        
        // Check if city already exists
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", city.name)
        
        let existingCities = try context.fetch(fetchRequest)
        
        let cityEntity: CityEntity
        
        if let existingCity = existingCities.first {
            // Update existing city
            cityEntity = existingCity
        } else {
            // Create new city
            cityEntity = CityEntity(context: context)
            cityEntity.id = Int32(city.id)
        }
        
        // Update city properties
        cityEntity.name = city.name
        
        // Save immediately
        try saveContext()
        
        // Verify save
        try verifyCity(name: city.name)
        
        print("📍 Saved city: \(city.name) with Name: \(city.name)")
    }

    private func verifyCity(name: String) throws {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let results = try context.fetch(fetchRequest)
        if let city = results.first {
            print("✅ Verified city exists: \(city.name) with ID: \(city.name)")
        } else {
            print("❌ Failed to verify city with Name: \(name)")
        }
    }

    public func insertWeatherInfo(_ weatherInfo: WeatherInfo, for cityName: String) throws {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: "CityEntity")
        fetchRequest.predicate = NSPredicate(format: "name == %@", cityName)
        
        let results = try context.fetch(fetchRequest)
        guard let cityEntity = results.first else { return }

        let weatherInfoEntity = WeatherInfoEntity(context: context)
        weatherInfoEntity.id = Int32(weatherInfo.id)
        weatherInfoEntity.name = weatherInfo.name
        weatherInfoEntity.date = weatherInfo.date
        
        let encoder = JSONEncoder()
        weatherInfoEntity.weatherData = try encoder.encode(weatherInfo.weather)
        weatherInfoEntity.temperatureData = try encoder.encode(weatherInfo.main)
        weatherInfoEntity.windData = try encoder.encode(weatherInfo.wind)
        
        weatherInfoEntity.city = cityEntity
        
        // Save immediately
        try saveContext()
    }
    
    public func retrieveCity(byName name: String) throws -> City? {
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: "CityEntity")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let results = try context.fetch(fetchRequest)
        guard let cityEntity = results.first else { return nil }
        return convertToCity(from: cityEntity)
    }
        
    public func retrieveAllCities() throws -> [City] {
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: "CityEntity")
        let results = try context.fetch(fetchRequest)
        return results.map { convertToCity(from: $0) }
    }
    
    public func retrieveWeatherInfo(forCityName cityName: String) throws -> [WeatherInfo] {
        let fetchRequest = NSFetchRequest<WeatherInfoEntity>(entityName: "WeatherInfoEntity")
        fetchRequest.predicate = NSPredicate(format: "city.name == %@", cityName)
        
        let results = try context.fetch(fetchRequest)
        return try results.map { try convertToWeatherInfo(from: $0) }
    }

    public func retrieveWeatherInfo(forCityName cityName: String, date: String) throws -> WeatherInfo? {
        let fetchRequest = NSFetchRequest<WeatherInfoEntity>(entityName: "WeatherInfoEntity")
        fetchRequest.predicate = NSPredicate(format: "city.name == %@", cityName)
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)
        
        let results = try context.fetch(fetchRequest)
        guard let weatherInfontity = results.first else { return nil }

        return try convertToWeatherInfo(from: weatherInfontity)
    }

    private func convertToCity(from entity: CityEntity) -> City {
        let weatherHistory = (try? Array(entity.weatherHistory).map { try convertToWeatherInfo(from: $0) }) ?? []
        return City(
            id: Int(entity.id),
            name: entity.name,
            weatherHistory: weatherHistory
        )
    }
    
    private func convertToWeatherInfo(from entity: WeatherInfoEntity) throws -> WeatherInfo {
        let decoder = JSONDecoder()
        
        let weather = try decoder.decode([Weather].self, from: entity.weatherData)
        let temperature = try decoder.decode(Tempreture.self, from: entity.temperatureData)
        let wind = try decoder.decode(Wind.self, from: entity.windData)
        
        return WeatherInfo(
            id: Int(entity.id),
            name: entity.name,
            weather: weather,
            main: temperature,
            wind: wind,
            date: entity.date
        )
    }
}

