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
        let fetchRequest = NSFetchRequest<CatEntity>(entityName: "CatEntity")
        var entities: [CatEntity] = []
        do {
            entities = try context.fetch(fetchRequest)
        } catch {
            print("Core Data couldn't fetch cats! \(error.localizedDescription)")
        }
        
        return entities
    }
}
