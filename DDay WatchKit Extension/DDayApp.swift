//
//  DDayApp.swift
//  DDay WatchKit Extension
//
//  Created by Hoju Choi on 2022/07/04.
//

import SwiftUI

@main
struct DDayApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
