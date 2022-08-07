//
//  RaccoonGramApp.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 26.07.2022.
//

import SwiftUI
import FirebaseCore

@main
struct RaccoonGramApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
