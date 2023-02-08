//
//  ContentViewModel.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/27.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var addCatIsPresented = false
    @Published var cats: [CatEntity] = []
        
    func loadCats() {
        cats = DataController.instance.fetchCats()
    }
}
