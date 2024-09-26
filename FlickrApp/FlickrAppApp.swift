//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Malkhasyan, Georgi (624-Extern) on 9/25/24.
//

import SwiftUI

@main
struct FlickrAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
