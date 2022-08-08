//
//  RaccoonGramApp.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 26.07.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct RaccoonGramApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
