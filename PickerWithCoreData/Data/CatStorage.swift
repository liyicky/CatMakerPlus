//
//  CatStorage.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/02/04.
//

import Foundation
import Combine
import CoreData

class CatStorage: NSObject {
    var cats = CurrentValueSubject<[CatEntity], Never>([])
    private var frc: NSFetchedResultsController<CatEntity>
    
    override init() {
        let request = CatEntity.fetchRequest()
        request.sortDescriptors = []
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DataController.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        frc.delegate = self
        do {
            print("Trying")
            try frc.performFetch()
        } catch {
            print("Couldn't fetch cats")
        }
    }
}

extension CatStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let cats = controller.fetchedObjects as? [CatEntity] else {
            print("Failed to fetch")
            return
        }
        print(cats)
        self.cats.value = cats
    }
}
