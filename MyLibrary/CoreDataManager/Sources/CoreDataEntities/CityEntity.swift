//
//  CityEntity.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

// CityEntity.swift
import CoreData

@objc(CityEntity)
public class CityEntity: NSManagedObject {
}

public extension CityEntity {
    @NSManaged var id: Int32
    @NSManaged var name: String
    @NSManaged var weatherHistory: Set<WeatherInfoEntity>
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }
    
    convenience init(context: NSManagedObjectContext, id: Int32, name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "CityEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.name = name
    }
}
