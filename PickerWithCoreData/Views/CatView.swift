//
//  CatView.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/27.
//

import SwiftUI

struct CatView: View {
    
    let cat: CatEntity
    let cellHeight: CGFloat = 200
    
    var body: some View {
        ZStack {
            catPhoto
            aboutCat

        }
        .frame(height: cellHeight)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .shadow(color: .primary.opacity(0.4), radius: 5, x: 0, y: 5)
        .padding(5)
    }
    
}

struct CatView_Previews: PreviewProvider {
    static let context = DataController.instance.context
    static let imageData = UIImage(named: "test.png")
    static let secondImageData = UIImage(named: "test2.png")
    static var previews: some View {
        let catEntity = CatEntity(context: context)
        catEntity.name = "Billy Jean"
        catEntity.age = Int16(1)
        catEntity.favoriteFood = "Shrimp"
        catEntity.picture = imageData?.pngData()
        
        let secondCatEntity = CatEntity(context: context)
        secondCatEntity.name = "Bobby Boy"
        secondCatEntity.age = Int16(16)
        secondCatEntity.favoriteFood = "Cake"
        secondCatEntity.picture = secondImageData?.pngData()
        return ScrollView(.vertical) {
            VStack {
                CatView(cat: catEntity)
                CatView(cat: secondCatEntity)
            }
        }
    }
}

extension CatView {
    private var catPhoto: some View {
        Image(uiImage: UIImage(data: cat.picture!)!)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
    }
    
    private var aboutCat: some View {
        VStack() {
            HStack(alignment: .top) {
                catName
                
                Spacer()
                catDeets
            }
            Spacer()
        }
        .frame(height: cellHeight)
    }
    
    private var catName: some View {
        Text(cat.name ?? "Nameless")
            .font(.title)
            .padding(5)
            .background(.ultraThinMaterial)
            .shadow(color: .primary.opacity(0.3), radius: 5)
    }
    
    private var catDeets: some View {
        VStack {
            Text("Age: \(String(cat.age))")
                .font(.footnote)
                .fontWeight(.light)
            Divider()
            Text("Fav Food: \(cat.favoriteFood ?? "None")")
                .font(.footnote)
                .fontWeight(.light)
        }
        .padding(2)
        .background(.ultraThinMaterial)
        .frame(width: 100)
        .shadow(color: .primary.opacity(0.3), radius: 5)
    }
}
