//
//  MZCryptoAppApp.swift
//  MZCryptoApp
//
//  Created by Mahmoud Zinji on 2022-10-17.
//

import SwiftUI

@main
struct MZCryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
