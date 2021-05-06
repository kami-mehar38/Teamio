//
//  TeamioApp.swift
//  Teamio
//
//  Created by Kamran Ramzan on 05/05/2021.
//

import SwiftUI
import Firebase

@main
struct TeamioApp: App {
    
    init() {
        /// initialization of Firebase
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            
            Login().preferredColorScheme(.light).environmentObject(AuthViewModel())
        }
    }
}
