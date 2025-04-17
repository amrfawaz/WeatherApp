//
//  WeatherInfoEntity.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import CoreData

@objc(WeatherInfoEntity)
public class WeatherInfoEntity: NSManagedObject {
}

public extension WeatherInfoEntity {
    @NSManaged var id: Int32
    @NSManaged var name: String
    @NSManaged var date: String?
    @NSManaged var weatherData: Data
    @NSManaged var temperatureData: Data
    @NSManaged var windData: Data
    @NSManaged var city: CityEntity
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<WeatherInfoEntity> {
        return NSFetchRequest<WeatherInfoEntity>(entityName: "WeatherInfoEntity")
    }
    
    convenience init(context: NSManagedObjectContext, id: Int32, name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "WeatherInfoEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.name = name
    }
}
