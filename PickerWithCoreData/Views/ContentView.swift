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
        NavigationStack {
            cards
            .padding(.horizontal, 10)
            .sheet(isPresented: $vm.addCatIsPresented) {
                NewCatView()
            }
            .navigationTitle("Cat App")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    settingsBtn
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    addCatBtn
                }
            }
            .onAppear {
                vm.loadCats()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private var cards: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(vm.cats) { cat in
                    CatView(cat: cat)
                }
            }
        }
    }
    
    private var addCatBtn: some View {
        Button {
            vm.addCatIsPresented.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
        }
    }
    
    private var settingsBtn: some View {
        Button {
            // open the settings
        } label: {
            Image(systemName: "gearshape")
        }
    }
}
