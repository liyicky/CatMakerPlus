//
//  CatEditView.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/02/02.
//

import SwiftUI

struct CatEditView: View {
    
    @Binding var name: String
    @Binding var favFood: String
    @Binding var age: String
    
    var body: some View {
        form
    }
}

extension CatEditView {
    private var form: some View {
        Form {
            Section("Cat Deets") {
                TextField("Cat Name", text: $name)
                TextField("Favorite Food", text: $favFood)
                TextField("Cat Name", text: $age)
            }
        }
    }
}

