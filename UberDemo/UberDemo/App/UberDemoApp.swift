//
//  UberDemoApp.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-13.
//

import SwiftUI

@main
struct UberDemoApp: App {
    // create singleton design pattern to focus on one instance, environmentObject are the ways to archieve it
    @StateObject var locationViewModel = SearchLocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
