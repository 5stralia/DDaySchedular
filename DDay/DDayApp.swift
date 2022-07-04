//
//  DDayApp.swift
//  DDay
//
//  Created by Hoju Choi on 2022/07/04.
//

import SwiftUI

@main
struct DDayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
