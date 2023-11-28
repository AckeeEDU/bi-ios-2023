//
//  FITstagramApp.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 10.10.2023.
//

import SwiftUI

@main
struct FITstagramApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(.pink) // Tint color is applied to all nested precedents
        }
        .environment(\.theme, .init(commentAuthor: .red))
    }
}
