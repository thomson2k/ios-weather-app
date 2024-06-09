//
//  ios_weather_app_finalApp.swift
//  ios-weather-app-final
//
//  Created by Tomasz Watroba on 09/06/2024.
//

import SwiftUI

@main
struct ios_weather_app_finalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
