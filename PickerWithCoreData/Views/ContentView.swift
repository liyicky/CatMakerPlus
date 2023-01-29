//
//  ContentView.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(vm.cats, id: \.self) { cat in
                        CatView(cat: cat)
                    }
                }
            }
            Button {
                vm.addCatIsPresented.toggle()
            } label: {
                Text("Add a cat 🐱")
                    .padding()
                    .background(.regularMaterial)
            }
        }
        .padding()
        .sheet(isPresented: $vm.addCatIsPresented) {
            NewCatView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
