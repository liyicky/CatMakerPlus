//
//  NewCatViewModel.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/23.
//

import Foundation
import SwiftUI
import PhotosUI

final class NewCatViewModel: ObservableObject {
    @Published var catName: String = ""
    @Published var catFavFood: String = ""
    @Published var catAge: String = ""
    @Published var catPhotos: [UnsplashPhoto] = []
    @Published var catPhoto: UnsplashPhoto = .init(description: "", urls: .init(raw: "", full: ""))
    
    init() {
        for _ in 1...3 {
            UnsplashAPIManager.instance.fetchRandomPhoto { photo in
                if let photo = photo {
                    self.catPhotos.append(photo)
                    self.catPhoto = photo
                }
            }
        }
    }
    
    func save() async {
        let newCat = CatEntity(context: DataController.instance.context)
        newCat.id = UUID()
        newCat.name = catName
        newCat.favoriteFood = catFavFood
        newCat.dataCreated = Date.now
        newCat.age = Int16(catAge)!
        newCat.picture = await catPhoto.getPhotoData()
        DataController.instance.save()
    }
}
