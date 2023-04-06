//
//  snaplog_mobileApp.swift
//  snaplog-mobile
//
//  Created by Samuel Wong on 6/4/2023.
//

import SwiftUI

@main
struct snaplog_mobileApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
