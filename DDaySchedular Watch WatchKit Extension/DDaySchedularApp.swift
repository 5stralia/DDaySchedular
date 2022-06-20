//
//  DDaySchedularApp.swift
//  DDaySchedular Watch WatchKit Extension
//
//  Created by Hoju Choi on 2022/06/18.
//

import SwiftUI

@main
struct DDaySchedularApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
