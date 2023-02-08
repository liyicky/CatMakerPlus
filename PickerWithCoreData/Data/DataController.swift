//
//  DataController.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/23.
//

import Foundation
import CoreData

struct DataController {
    static let instance = DataController()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        self.container = NSPersistentContainer(name: "Stash")
        self.context = self.container.viewContext
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        print("Core Data Initialized")
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        if context.hasChanges {
            do {
                try context.save()
                print("Core Data saved!")
            } catch {
                print("Core Data couldn't save! \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    func fetchCats() -> [CatEntity] {
        print("Fetched Cats")
        var entities: [CatEntity] = []
        do {
            entities = try context.fetch(CatEntity.fetchRequest())
        } catch {
            print("Core Data couldn't fetch cats! \(error.localizedDescription)")
        }
        
        return entities
    }
    
    func fetchCat(cat: CatEntity) -> CatEntity {
        let request = CatEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", cat.id! as CVarArg)
        let results = try? context.fetch(request) as [CatEntity]
        if let result = results?.first {
            return result
        } else {
            print("Core Data fetched no results")
            return cat
        }
    }
}
