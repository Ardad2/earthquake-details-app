//
//  CSE335Lab7App.swift
//  CSE335Lab7
//
//  Created by Arjun Dadhwal on 4/2/23.
//

import SwiftUI

@main
struct CSE335Lab7App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(displayEarthquakes: [], address: "Tempe", lon: 0.0, lat: 0.0)
        }
    }
}
