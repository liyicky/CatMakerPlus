//
//  CatEditViewModel.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/02/02.
//

import Foundation

final class CatEditViewModel: ObservableObject {
    
    var cat: CatEntity? = nil {
        willSet {
            save()
        }
        
        didSet {
            if let cat = cat {
                self.catName = cat.name ?? ""
                self.catFavFood = cat.favoriteFood ?? ""
                self.catAge = String(cat.age)
            }
        }
    }
    
    @Published var catName: String = ""
    @Published var catFavFood: String = ""
    @Published var catAge: String = ""
    
    func save() {
        guard let cat else {
            return
        }
        
        cat.name = catName
        cat.favoriteFood = catFavFood
        cat.dataCreated = Date.now
        cat.age = Int16(catAge)!
        DataController.instance.save()
    }
}
