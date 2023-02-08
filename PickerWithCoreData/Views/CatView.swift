//
//  CatView.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/27.
//

import SwiftUI

struct CatView: View {
    
    let cat: CatEntity
    @State var preloadedCatPicture: UIImage
    @State var cellHeight: CGFloat = 200
    @State var name: String
    @State var favFood: String
    @State var age: String
    
    init(cat: CatEntity) {
        self.cat = cat
        self.name = cat.name ?? "Nameless"
        self.favFood = cat.favoriteFood ?? "Nothing"
        self.age = String(cat.age)
        self.preloadedCatPicture = UIImage(data: cat.picture!)!
    }
    
    var extended: Bool {
        cellHeight == 400
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                catPhoto(geometry)
                aboutCat
            }
            .frame(maxWidth: geometry.size.width)
        }
        .frame(height: cellHeight)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .shadow(color: .primary.opacity(0.4), radius: 5, x: 0, y: 5)
        .padding(5)
        .onAppear {
            reload()
        }
    }
    
    func reload() {
        self.name = cat.name ?? "Nameless"
        self.favFood = cat.favoriteFood ?? "Nothing"
        self.age = String(cat.age)
    }
}

struct CatView_Previews: PreviewProvider {
    static let context = DataController.instance.context
    static let imageData = UIImage(named: "test.png")
    static let secondImageData = UIImage(named: "test2.png")
    static var previews: some View {
        let catEntity = CatEntity(context: context)
        catEntity.id = UUID()
        catEntity.name = "Billy Jean"
        catEntity.age = Int16(1)
        catEntity.favoriteFood = "Shrimp"
        catEntity.picture = imageData?.pngData()
        
        let secondCatEntity = CatEntity(context: context)
        secondCatEntity.id = UUID()
        secondCatEntity.name = "Bobby Boy"
        secondCatEntity.age = Int16(16)
        secondCatEntity.favoriteFood = "Cake"
        secondCatEntity.picture = secondImageData?.pngData()
        return ScrollView(.vertical) {
            VStack {
                CatView(cat: catEntity)
                CatView(cat: secondCatEntity)
            }.frame(width: 380)
        }
    }
}

extension CatView {
    @ViewBuilder
    func catPhoto(_ geometry: GeometryProxy) -> some View {
        Image(uiImage: preloadedCatPicture)
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: cellHeight)
            .allowsHitTesting(false)
    }
    
    private var aboutCat: some View {
        VStack() {
            HStack(alignment: .top) {
                catName
                Spacer()
                catDeets
            }
            Spacer()
            HStack {
                Spacer()
                if extended {
                    catEditButton
                        .opacity(extended ? 1 : 0)
                }
            }
        }
        .frame(height: cellHeight)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                cellHeight = extended ? 200 : 400
            }
            print("\(cat.name!): \(cat.id!) - Expanded? \(cellHeight == 200 ? "No" : "Yes")")
        }
    }
    
    private var catName: some View {
        Text(name)
            .font(.title)
            .padding(5)
            .background(.ultraThinMaterial)
            .clipShape(RoundedCorner(radius: 5, corners: [.bottomRight]))
            .shadow(color: .primary.opacity(0.3), radius: 5)
    }
    
    private var catDeets: some View {
        VStack {
            Text("Age: \(age)")
                .font(.footnote)
                .fontWeight(.light)
            Divider()
            Text("Fav Food: \(favFood)")
                .font(.footnote)
                .fontWeight(.light)
        }
        .padding(2)
        .background(.ultraThinMaterial)
        .frame(width: 100)
        .clipShape(RoundedCorner(radius: 5, corners: [.bottomLeft]))
        .shadow(color: .primary.opacity(0.3), radius: 5)
    }
    
    private var catEditButton: some View {
        NavigationLink {
            CatDetailsView(cat: cat)
        } label: {
            
            Image(systemName: "gearshape.fill")
                .foregroundStyle(
                    .white.opacity(0.5).gradient.shadow(
                        .inner(color: .black, radius: 2, x: 2, y: 1)
                    )
                )
                .font(.system(size: 35))
                .background(
                    RoundedCorner(radius: 5, corners: [.topLeft])
                        .frame(width: 50, height: 50)
                        .foregroundStyle(
                            .white.opacity(0.3).gradient.shadow(
                                .inner(color: .black, radius: 2, x: 2, y: 2)
                            )
                        )
                )
        }

    }
}
