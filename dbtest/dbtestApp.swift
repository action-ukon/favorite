//
//  dbtestApp.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import SwiftUI

@main
struct dbtestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(User())
                .environmentObject(Order())
        }
    }
}
