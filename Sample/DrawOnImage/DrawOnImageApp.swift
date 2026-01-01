//
//  DrawOnImageApp.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI

@main
struct DrawOnImageApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    ContentView()
                }
                .tabItem {
                    Label("none", systemImage: "")
                }
                NavigationStack {
                    ContentView( image: UIImage(named: "diagram1"))
                }
                .tabItem {
                    Label("diagram1", systemImage: "")
                }
                NavigationStack {
                    ContentView( image: UIImage(named: "diagram2"))
                }
                .tabItem {
                    Label("diagram2", systemImage: "")
                }
            }
        }
    }
        
}

