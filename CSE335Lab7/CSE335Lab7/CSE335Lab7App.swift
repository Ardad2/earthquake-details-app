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
            ContentView(address: "Tempe", lon: "", lat: "")
        }
    }
}
