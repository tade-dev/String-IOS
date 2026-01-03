//
//  String_IOSApp.swift
//  String-IOS
//
//  Created by BSTAR on 27/12/2025.
//

import SwiftUI

@main
struct String_IOSApp: App {
    
    @StateObject private var rootViewModel = RootViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
                .environmentObject(homeViewModel)
        }
    }
}
