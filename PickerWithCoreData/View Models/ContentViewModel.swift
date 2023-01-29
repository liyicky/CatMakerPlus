//
//  ContentViewModel.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/27.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var addCatIsPresented = false
    @Published var cats = [CatEntity]()
    
    init() {
        self.cats = DataController.instance.fetchCats()
    }
}
