//
//  PickerWithCoreDataApp.swift
//  PickerWithCoreData
//
//  Created by Jason Cheladyn on 2023/01/23.
//

import SwiftUI

@main
struct PickerWithCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DataController.instance.context)
                .preferredColorScheme(.light)
        }
    }
}
