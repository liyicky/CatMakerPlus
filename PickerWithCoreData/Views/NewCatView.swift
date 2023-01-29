//
//  NewCatView.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/23.
//

import SwiftUI

struct NewCatView: View {
    
    @StateObject private var vm = NewCatViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        form
    }
}

struct NewCatView_Previews: PreviewProvider {
    static var previews: some View {
        NewCatView()
    }
}

extension NewCatView {
    private var form: some View {
        VStack {
            Text("New Cat")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.top)
            Form {
                catDeets
                catPhoto
                catSaveBtn
            }
        }
    }
    
    private var catDeets: some View {
        Section("Cat deets") {
            TextField("Name of the cat", text: $vm.catName)
            TextField("Favorite food", text: $vm.catFavFood)
            TextField("How old is it", text: $vm.catAge)
                .keyboardType(.decimalPad)
        }

    }
    
    private var catPhoto: some View {
        Section("Photo of the cat") {
            catPicker
            catPreview
        }
    }
    
    private var catPicker: some View {
        Picker("Select a cat", selection: $vm.catPhoto) {
            ForEach(vm.catPhotos, id: \.self) {
                Text($0.permaDescription)
            }
        }
    }
    
    private var catPreview: some View {
        AsyncImage(url: URL(string: vm.catPhoto.urls.raw)) { image in
            image
                .resizable()
                .scaledToFill()

        } placeholder: {
            Color.gray
        }
        .frame(maxWidth: .infinity)
        .frame(width: 250, height: 250)
        .overlay(alignment: .topLeading) {
            Text(vm.catPhoto.permaDescription)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5, style: .circular))
                .padding(3)
        }
        .padding()
    }
    
    private var catSaveBtn: some View {
        Section("Save Button") {
            Button {
                Task {
                    await vm.save()
                    dismiss()
                }
            } label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Save")
                }
            }
        }
    }
}

