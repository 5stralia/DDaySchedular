//
//  DDaySchedularApp.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/17.
//

import SwiftUI

@main
struct DDaySchedularApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
