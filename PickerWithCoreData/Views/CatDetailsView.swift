//
//  CatDetailsView.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/02/02.
//

import SwiftUI

struct CatDetailsView: View {
    
    let cat: CatEntity
    @StateObject var vm = CatEditViewModel()

    var body: some View {
        VStack {
            header
            details
            Spacer()
            editBtn
        }
        .navigationTitle(vm.catName)
        .onAppear {
            vm.cat = cat
        }
    }
}

extension CatDetailsView {
    private var header: some View {
        ZStack {
            Image(uiImage: UIImage(data: cat.picture!)!)
                .resizable()
                .scaledToFill()
        }
        .frame(height: 300)
        .clipped()
    }
    
    private var details: some View {
        VStack {
            CatDetailsTextView(title: "Age", textBody: String(cat.age) + " years old")
            CatDetailsTextView(title: "Favorite Food", textBody: cat.favoriteFood ?? "Nothing")
            CatDetailsTextView(title: "Created On", textBody: cat.dataCreated?.formatted() ?? "???")
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 4)
    }
    
    private var editBtn: some View {
        NavigationLink {
            CatEditView(name: $vm.catName, favFood: $vm.catFavFood, age: $vm.catAge)
        } label: {
            HStack {
                Spacer()
                Image(systemName: "pencil.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                Text("Edit")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.blue.opacity(0.2))
            )
            .padding(.horizontal, 4)
        }
    }
}

struct CatDetailsTextView: View {

    let title: String
    let textBody: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
            Spacer()
            Text(textBody)
        }
        .frame(maxHeight: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(
                    .orange.opacity(0.2).shadow(.inner(color: .black.opacity(0.5), radius: 2, x: 1, y: 1))
                )
        )
    }
}

