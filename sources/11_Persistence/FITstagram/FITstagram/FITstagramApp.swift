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
            let _ = print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))
//            let _ = print(Bundle.main.bundlePath)
            ContentView()
                .tint(.pink) // Tint color is applied to all nested precedents
        }
        .environment(\.theme, .init(commentAuthor: .red))
        .environment(JSONAPIService())
    }
}

extension UserDefaults {
    static let custom = UserDefaults(suiteName: "custom")!
}
