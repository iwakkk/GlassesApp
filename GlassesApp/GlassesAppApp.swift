//
//  GlassesAppApp.swift
//  GlassesApp
//
//  Created by Felicia Stevany Lewa on 12/06/25.
//

import SwiftUI

@main
struct GlassesAppApp: App {
    @StateObject private var arViewModel = ARViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(arViewModel)
            }
        }
    }
}
