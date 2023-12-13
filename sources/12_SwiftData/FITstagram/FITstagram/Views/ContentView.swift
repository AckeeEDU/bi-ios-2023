//
//  ContentView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 24.10.2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(JSONAPIService.self) var jsonAPI
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        TabView {
            PostListView(viewModel: .init(
                jsonAPI: jsonAPI,
                modelContainer: modelContext.container
            ))
            .tabItem {
                Label(
                    "Feed",
                    systemImage: "photo.on.rectangle"
                )
            }
            
            OnboardingView()
                .tabItem {
                    Label(
                        "Onboarding",
                        systemImage: "questionmark.app"
                    )
                }
            
            MyProfileView()
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "person"
                    )
                }
        }
    }
}

#Preview {
    ContentView()
}
